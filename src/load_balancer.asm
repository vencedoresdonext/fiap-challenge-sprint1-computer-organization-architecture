; ============================================
; Módulo de Gerenciamento de Carga
; ============================================

.section .data
num_veiculos:   .word 3              ; quantidade de veículos conectados
soc_base:       .word 80, 20, 50     ; estado de carga (%) de cada veículo

energia_solar:  .word 50             ; energia disponível via solar
energia_bat:    .word 20             ; energia disponível na bateria
energia_rede:   .word 30             ; energia disponível da rede elétrica

.section .text
.globl _start

_start:

    ; --------------------------------------------------
    ; ETAPA 1: Calcular demanda total de energia
    ; --------------------------------------------------
    ; Para cada veículo:
    ; demanda_individual = 100 - SOC
    ; demanda_total = soma de todas as demandas
    ; --------------------------------------------------

    la t0, soc_base        ; t0 aponta para o vetor de SOC
    lw t1, num_veiculos    ; t1 = quantidade de veículos

    li t2, 0               ; t2 = acumulador de demanda total
    li t3, 100             ; constante: carga máxima (100%)

calc_loop:
    lw t4, 0(t0)           ; t4 = SOC atual do veículo
    sub t5, t3, t4         ; t5 = energia necessária para completar 100%
    add t2, t2, t5         ; acumula na demanda total

    addi t0, t0, 4         ; avança para o próximo veículo
    addi t1, t1, -1        ; decrementa contador
    bnez t1, calc_loop     ; continua enquanto houver veículos

    ; --------------------------------------------------
    ; ETAPA 2: Carregar fontes de energia (uma única vez)
    ; --------------------------------------------------
    ; Evita múltiplos acessos à memória (otimização)
    ; --------------------------------------------------

    lw t0, energia_solar   ; t0 = energia solar disponível
    lw t1, energia_bat     ; t1 = energia da bateria
    lw t3, energia_rede    ; t3 = energia da rede

    add t4, t0, t1         ; t4 = solar + bateria
    add t5, t4, t3         ; t5 = energia total disponível

    ; --------------------------------------------------
    ; ETAPA 3: Decisão da fonte de energia
    ; --------------------------------------------------
    ; Prioridade:
    ; 1) Apenas solar (mais eficiente)
    ; 2) Solar + bateria
    ; 3) Rede elétrica
    ; 4) Falha (energia insuficiente)
    ;
    ; Estratégia:
    ; - Minimizar branches (menos desvios = mais desempenho)
    ; --------------------------------------------------

    blt t0, t2, use_mix    ; se solar < demanda → tenta combinação
    li a0, 1               ; modo 1: apenas solar
    j end

use_mix:
    blt t4, t2, use_grid   ; se solar+bateria < demanda → tenta rede
    li a0, 2               ; modo 2: solar + bateria
    j end

use_grid:
    blt t5, t2, no_energy  ; se nem total atende → falha
    li a0, 3               ; modo 3: usar rede elétrica
    j end

no_energy:
    li a0, 0               ; modo 0: energia insuficiente

end:

    ; --------------------------------------------------
    ; ETAPA 4: Modo de baixo consumo
    ; --------------------------------------------------
    ; CPU entra em espera até ocorrer interrupção.
    ; Ideal para sistemas embarcados com foco em eficiência energética.
    ; --------------------------------------------------

sleep:
    wfi                    ; Wait For Interrupt (economia de energia)
    j sleep                ; mantém o sistema em espera contínua
