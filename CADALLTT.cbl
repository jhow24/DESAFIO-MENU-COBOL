      ******************************************************************
      * Author:Johnathan Silva
      * Date:05/01/2023
      * Purpose: cadastro de alunos
      * Tectonics: cobc
      * TRANSFORMAR DE PROGRAMA PARA MODULO
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CADALLTT.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT ALUNOS ASSIGN TO
               'C:\Users\johnatsi\Estudos\Cobol\bin\ALUNOS.DAT'
               ORGANISATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY  IS ID-ALUNO
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD ALUNOS.
          COPY FD_ALLTT.

       WORKING-STORAGE SECTION.
       01 WS-REGISTRO                 PIC X(22) VALUE SPACES.
       01 FILLER REDEFINES WS-REGISTRO.
           03 WS-ID-ALUNO             PIC 9(02).
           03 WS-NUM-ALUNO            PIC 9(02).
           03 WS-NM-ALUNO             PIC X(20).
           03 WS-TEL-ALUNO            PIC 9(12).
       77 WS-FS                       PIC 99.
           88 FS-OK                   VALUE 0.
       77 WS-EOF                      PIC X.
           88 EOF-OK                  VALUE 'S' FALSE 'N'.
       77 WS-EXIT                     PIC X     VALUE 'N'.
           88 EXIT-OK                 VALUE 'F' FALSE 'N'.

       LINKAGE SECTION.
       01 LK-COM-AREA.
           03 LK-MENSAGEM             PIC X(40).
       PROCEDURE DIVISION USING LK-COM-AREA.
       MAIN-PROCEDURE.
            DISPLAY '*** CADASTRO DE ALUNOS ***'
            SET EXIT-OK               TO FALSE
            PERFORM P300-CADASTRA     THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
            .
       P300-CADASTRA.
           SET EOF-OK                  TO FALSE
           SET FS-OK                   TO TRUE

           DISPLAY 'PARA REGISTRAR UM ALUNO,INFORME: '
           DISPLAY 'Informe um ID para a identicacao: '
           ACCEPT WS-ID-ALUNO

           DISPLAY 'Digite o numero do aluno: '
           ACCEPT WS-NUM-ALUNO

           DISPLAY 'Um nome para o aluno: '
           ACCEPT WS-NM-ALUNO

           DISPLAY 'Digite o telefone do aluno: '
           ACCEPT WS-TEL-ALUNO

           OPEN I-O ALUNOS

           IF WS-FS EQUAL 35
               OPEN OUTPUT ALUNOS
           END-IF

           IF FS-OK THEN
               MOVE WS-ID-ALUNO        TO ID-ALUNO
               MOVE WS-NUM-ALUNO       TO NUM-ALUNO
               MOVE WS-NM-ALUNO        TO NM-ALUNO
               MOVE WS-TEL-ALUNO       TO TEL-ALUNO

               WRITE REG-ALUNOS
                   INVALID KEY
                       DISPLAY 'ALUNO JA CADASTRADO!'
                   NOT INVALID KEY
                       DISPLAY 'ALUNO GRAVADO COM SUCESSO!'
               END-WRITE
           ELSE
               DISPLAY 'ERRO AO ABRIR O ARQUIVO DE ALUNOS.'
               DISPLAY 'FILE STATUS: ' WS-FS
           END-IF

           CLOSE ALUNOS

           DISPLAY 'Tecle: '
                '<QUALQUER TECLA> para continuar, ou <F> para finalizar'
           ACCEPT WS-EXIT
           .
       P300-FIM.

       P900-FIM.
            GOBACK.
       END PROGRAM CADALLTT.
