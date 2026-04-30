def gerenciar_carga():
    soc_base = [80, 20, 50]
    num_veiculos = len(soc_base)
    
    energia_solar = 50
    energia_bat = 20
    energia_rede = 30

    # demanda_individual = 100 - SOC
    demanda_total = sum(100 - soc for soc in soc_base)
    
    print(f"Demanda Total: {demanda_total}%")

    # Somar fontes de energia
    solar_mais_bateria = energia_solar + energia_bat
    energia_total_disponivel = energia_solar + energia_bat + energia_rede

    # Decisão da fonte (Prioridades)
    # a0 no assembly guarda o resultado do modo
    modo = 0 

    if energia_solar >= demanda_total:
        modo = 1  # Apenas solar
        print("Modo Selecionado: 1 (Apenas Solar)")
    elif solar_mais_bateria >= demanda_total:
        modo = 2  # Solar + Bateria
        print("Modo Selecionado: 2 (Solar + Bateria)")
    elif energia_total_disponivel >= demanda_total:
        modo = 3  # Usar rede elétrica
        print("Modo Selecionado: 3 (Rede Elétrica)")
    else:
        modo = 0  # Falha
        print("Modo Selecionado: 0 (Energia Insuficiente)")

    return modo

#Simulação do Sleep
if __name__ == "__main__":
    resultado = gerenciar_carga()
    print("Sistema entrando em modo de espera (WFI)...")
