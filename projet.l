%{
#include <stdlib.h>
#include <string.h>
#include<stdio.h>
#include "projet1.tab.h"


int ligne=1;
int col=1;
int nb_err_lex;
%}
Bib_CALCUL #CALCUL
Bib_BOUCLE #BOUCLE
Bib_TAB #TAB
Mc_prog Program
Mc_const CONST
Mc_Int INT
Mc_Double DOUBLE
Mc_Char CHAR
Mc_String STRING
CST_Int [1-9][0-9]*|0
CST_Double [0-9]*\.[0-9]*|0
CST_Char '.'
STR ["][^\"]*["]
Mc_Print PRINT
Mc_read READ
Mc_While WHILE
Mc_For FOR
Mc_IF IF
IDF [A-Z][a-zA-Z0-9]*
Affect =
PV ;
deuxPoints :
virgule ,
Par_Ouv \(
Par_Fer \)
Acolade_Ouv \{
Acolade_Fer \}
Acolade1_Ouv \[
Acolade1_Fer \]
comment "/""/"[^/]*"/""/"
Opr_Art \+|\*|\/
Moins \-
Opr_Log <|==|>|<=|>=|!=
sautDeligne \n
%%
{Bib_CALCUL} { col=col+strlen(yytext); return Bib_CALCUL;}
{Bib_BOUCLE} { col=col+strlen(yytext); return Bib_BOUCLE;}
{Bib_TAB} { col=col+strlen(yytext); return Bib_TAB;}
{Mc_prog} { col=col+strlen(yytext); return Mc_prog;}
{Mc_const} { col=col+strlen(yytext); return Mc_const;}
{Mc_Int} {  col=col+strlen(yytext);  return Mc_Int;}
{Mc_Double} { col=col+strlen(yytext); return Mc_Double;}
{Mc_Char} { col=col+strlen(yytext); return Mc_Char;}
{Mc_String} { col=col+strlen(yytext); return Mc_String;}
{CST_Int} {col = col + strlen(yytext);
            if(atoi(yytext)>=-32768 && atoi(yytext)<=32767)
			                	 {
                           yylval.entier=atoi(yytext);
		                  		 return CST_Int;
			                	 }else
                              {
              printf ("Erreur Lexicale a la ligne %d a la colonne %d :l'entier doit etre entre -32768 et 32767 \n ",ligne, col);
          }}
{CST_Double} { col=col+strlen(yytext); return CST_Double;}
{CST_Char} { col=col+strlen(yytext); return CST_Char;}
{STR} { col=col+strlen(yytext); return STR;}
{Mc_Print} { col=col+strlen(yytext); return Mc_Print;}
{Mc_read} { col=col+strlen(yytext); return Mc_read;}
{Mc_While} { col=col+strlen(yytext); return Mc_While;}
{Mc_For} { col=col+strlen(yytext); return Mc_For;}
{Mc_IF} { col=col+strlen(yytext); return Mc_IF;}
{IDF} {
              
               col= col +strlen(yytext);
                 if (yyleng<=12) 
                  { 
                    return IDF;
                   }
                   else
                   {
                     printf ("Erreur Lexicale:IDF trop long a la ligne %d a la colonne %d : IDF trop long \n ",ligne, col);
                   }  
		      }
{Affect} { col=col+strlen(yytext); return Affect;}
{PV} { col=col+strlen(yytext); return PV;}
{deuxPoints} { col=col+strlen(yytext); return deuxPoints;}
{virgule} { col=col+strlen(yytext); return virgule;}
{Par_Ouv} { col=col+strlen(yytext); return Par_Ouv;}
{Par_Fer} { col=col+strlen(yytext); return Par_Fer;}
{Acolade_Ouv} { col=col+strlen(yytext); return Acolade_Ouv;}
{Acolade_Fer} { col=col+strlen(yytext); return Acolade_Fer;}
{Acolade1_Ouv} { col=col+strlen(yytext); return Acolade1_Ouv;}
{Acolade1_Fer} { col=col+strlen(yytext); return Acolade1_Fer;}
{comment}
{Opr_Art} { col=col+strlen(yytext); return Opr_Art;}
{Moins} { col=col+strlen(yytext); return Moins;}
{Opr_Log} { col=col+strlen(yytext); return Opr_Log;}
{sautDeligne} { col=col+strlen(yytext);  ligne++; col=1; return sautDeligne;}
[ \t]
. {nb_err_lex++;printf("erreur lexicale a la ligne %d et la colonne %d generee par %s\n",ligne,col,yytext);return nb_err_lex;}
%%
int yywrap(){}