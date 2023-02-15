      ******************************************************************
      * Author:Johnathan Silva
      * Date:05/01/2023
      * Purpose: Deletar contatos
      * Tectonics: cobc
      * ATUALIZANDO DE PROGRAMA PARA MODULO
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DELCONTT.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT CONTATOS ASSIGN TO
               'C:\Users\johnatsi\Estudos\Cobol\bin\CONTATOS.DAT'
               ORGANISATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY  IS ID-CONTATO
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD CONTATOS.
          COPY FD_CONTT.

       WORKING-STORAGE SECTION.
       01 WS-REGISTRO                 PIC X(22) VALUE SPACES.
       01 FILLER REDEFINES WS-REGISTRO.
           03 WS-ID-CONTATO           PIC 9(02).
           03 WS-NM-CONTATO           PIC X(20).
       77 WS-FS                       PIC 99.
           88 FS-OK                   VALUE 0.
       77 WS-EOF                      PIC X.
           88 EOF-OK                  VALUE 'S' FALSE 'N'.
       77 WS-EXIT                     PIC X     VALUE 'N'.
           88 EXIT-OK                 VALUE 'F' FALSE 'N'.
       77 WS-CONFIRM                  PIC X    VALUE SPACES.

       LINKAGE SECTION.
       01 LK-COM-AREA.
           03 LK-MENSAGEM             PIC X(40).
       PROCEDURE DIVISION USING LK-COM-AREA.
       MAIN-PROCEDURE.
            DISPLAY '*** DELETAR CONTATOS ***'
            SET EXIT-OK               TO FALSE
            PERFORM P300-DELETAR      THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
            .
       P300-DELETAR.
           SET EOF-OK                  TO FALSE
           SET FS-OK                   TO TRUE

           MOVE SPACES                 TO WS-CONFIRM

           OPEN I-O CONTATOS

           IF FS-OK THEN
               DISPLAY 'INFORME O NUMERO DE INDENTICACAO DO CONATO'
               ACCEPT ID-CONTATO

               READ CONTATOS INTO WS-REGISTRO
                KEY IS ID-CONTATO
                   INVALID KEY
                       DISPLAY 'CONTATO NAO EXISTE'
                   NOT INVALID KEY
                       DISPLAY 'Nome atual: ' WS-NM-CONTATO
                       DISPLAY 'TECLE: '
                               '<S> para confirmar ou <QUALQUER TECLA>'
                               'para continuar com o atual.'
                       ACCEPT WS-CONFIRM
                       IF WS-CONFIRM EQUAL 'S' THEN
                           DELETE CONTATOS RECORD
                           DISPLAY 'Excluido com sucesso!'
                       ELSE
                           DISPLAY 'Contato nao excluido!'
                       END-IF
               END-READ
           ELSE
               DISPLAY 'ERRO AO ABRIR O ARQUIVO DE CONTATOS.'
               DISPLAY 'FILE STATUS: ' WS-FS
           END-IF

           CLOSE CONTATOS

           DISPLAY 'Tecle: '
                '<QUALQUER TECLA> para continuar, ou <F> para finalizar'
           ACCEPT WS-EXIT
           .
       P300-FIM.

       P900-FIM.
            GOBACK.
       END PROGRAM DELCONTT.
