      ******************************************************************
      * Author:Johnathan Silva
      * Date:05/01/2023
      * Purpose: Menu PARA CADASTRO DE CONTATO
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MENUCNTT.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01 WS-COM-AREA.
           03 WS-MENSAGEM                   PIC X(40).
       77 WS-OPCAO                          PIC X.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            PERFORM P300-PROCESSA     THRU P300-FIM UNTIL WS-OPCAO = 'S'
            PERFORM P900-FIM
            .
       P300-PROCESSA.

            MOVE SPACES                     TO WS-OPCAO
            DISPLAY '*********************************************'
            DISPLAY '*          SISTEMA DE CONTATOS              *'
            DISPLAY '*********************************************'
            DISPLAY '|                                           |'
            DISPLAY '| ESCOLHA UMA OPCAO:                        |'
            DISPLAY '| 1 - INCLUIR CONTATO                       |'
            DISPLAY '| 1 - LISTAR CONTATO                        |'
            DISPLAY '| 1 - CONSULTAR CONTATO                     |'
            DISPLAY '| 1 - ALTERAR CONTATO                       |'
            DISPLAY '| 1 - EXCLUIR CONTATO                       |'
            DISPLAY '|                                           |'
            DISPLAY '|-------------------------------------------|'
            ACCEPT WS-OPCAO

            EVALUATE WS-OPCAO
               WHEN '1'
                MOVE ' *** INCLUSAO DE CONTATO ***' TO WS-MENSAGEM
                CALL 'C:\Users\johnatsi\Estudos\Cobol\bin\CADCONTT'
                                                    USING WS-COM-AREA
               WHEN '2'
                MOVE ' *** LISTAGEM DE CONTATO ***' TO WS-MENSAGEM
                CALL 'C:\Users\johnatsi\Estudos\Cobol\bin\LISCNTT'
                                                    USING WS-COM-AREA
               WHEN '3'
                MOVE ' *** CONSULTA DE CONTATO ***' TO WS-MENSAGEM
                CALL 'C:\Users\johnatsi\Estudos\Cobol\bin\CONSCTT'
                                                    USING WS-COM-AREA
               WHEN '4'
                MOVE ' *** ALTERAÇÃO DE CONTATO ***' TO WS-MENSAGEM
                CALL 'C:\Users\johnatsi\Estudos\Cobol\bin\ALTCONTT'
                                                    USING WS-COM-AREA
               WHEN '5'
                MOVE ' ***  DELETAR CONTATO  ***' TO WS-MENSAGEM
                CALL 'C:\Users\johnatsi\Estudos\Cobol\bin\DELCONTT'
                                                    USING WS-COM-AREA
               WHEN 'S'
                   DISPLAY 'OBRIGADO VOLTE SEMPRE!'
               WHEN 's'
                   DISPLAY 'OBRIGADO VOLTE SEMPRE!'
               WHEN OTHER
                  DISPLAY 'OPCAO INVALIDA.'
            END-EVALUATE
            .
        P300-FIM.
        P900-FIM.
            STOP RUN.
       END PROGRAM MENUCNTT.
