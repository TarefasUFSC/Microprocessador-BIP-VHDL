# Microprocessador-BIP-VHDL
Projeto feito para implementar o BIP em um FPGA

## Diagrama do projeto
![Diagrama_do_Sistema](https://user-images.githubusercontent.com/42501669/183143530-79fb0cea-ab42-4fe4-895a-eaede9f89866.png)


## Tabela OPCODE
![image](https://user-images.githubusercontent.com/42501669/183143602-fac425bc-17d0-40a5-9372-6d0371e9a234.png)

### Descrição


| Instrução | Descrição
------|---------
| STOP | Para o programa (HALT) | 
| STO | STO {endereço} salva o dado que esta no acumulador no {endereço} na RAM |
| LD | LD {endereço} Carrega para o acumulador o que esta no {endereço} da RAM |
| LDI | LDI {valor} carrega o {valor} diretamente para o acumulador |
| ADD | ADD {endereço} soma o que está no {endereço} da RAM com o que esta no acumulador -} ACC = ACC + B |
| ADDI | ADDI {valor} soma {valor} com o que esta no acumulador -} ACC = ACC + {valor} |
| SUB | SUB {endereço} subtrai o que está no acumulador com o que esta no {endereço} da RAM -} ACC = ACC - B |
| SUBI | SUBI {valor} subtrai acumulador com o que esta no {valor} -} ACC = ACC - {valor} |
| INP | Carrega no acumulador o que esta nas chaves conectadas no FPGA |
