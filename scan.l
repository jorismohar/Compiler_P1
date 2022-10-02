%{
    
    #include <iostream>

    using namespace std;
    string lexema;

    void erro( string std ){
        cout << "Erro: Identificador inválido: " << std << endl;
    }
    /*void stringprint(string str1){
        int l = sizeof(str1);
        printf("%*.*s", str1[0], str1[l]-2);
    }*/
%}
/* Coloque aqui definições regulares */
D	        [0-9]
L	        [A-Za-z_]

WS	        [ \t\n]
ID          ($|_|{L})({L}|{D}|_|"@"({L}|{D}|"@")|({L}|{D}|"@")"@")*
IF          (i|I)(f|F)
FOR         (f|F)(o|O)(r|R)
INT         {D}+
FLOAT       {INT}("."{INT})?([Ee]("+"|"-")?{INT})?
STRING      ((\"([[.\".]]|[[."".]]|[^"]|[^\\])*\")|(\'([^']|[[.\'.]]|[[."".]])*\'))  
COMENTARIO  ("//"(.|"/*"|"*/")*\n|("/*"(.|\n)*"*/"))
STRING2     ("`".*"`")
ERRO        (($|{L}|{D}|"@"|_)*@({L}|{D}|"@"|_)*|$?({L}|{D}|"@"|_)*($)+({L}|{D}|"@"|_)*)

%% /* */
    /* Padrões e ações. Nesta seção, comentários devem ter um tab antes */

{WS}	        { /* ignora espaços, tabs e '\n' */ }
{IF}            {lexema = yytext; return _IF; }
{FOR}           {lexema = yytext; return _FOR; }
{INT}           {lexema = yytext; return _INT; }
{ID}            {lexema = yytext; return _ID; }
{STRING}        {lexema = yytext; return _STRING;}
{STRING2}       {lexema = yytext; return _STRING2;}
{COMENTARIO}    {lexema = yytext; return _COMENTARIO;}
{FLOAT}         {lexema = yytext; return _FLOAT; }
">="            {lexema = yytext; return _MAIG; }
"<="            {lexema = yytext; return _MEIG; }
"=="            {lexema = yytext; return _IG; }
"!="            {lexema = yytext; return _DIF; }
{ERRO}          {erro(lexema = yytext);}
.               {lexema = yytext; return *yytext; }
          /* Essa deve ser a última regra. Dessa forma qualquer caractere isolado será retornado pelo seu código ascii. */ 

%%

/* Não coloque nada aqui - a função main é automaticamente incluída na hora de avaliar e dar a nota. */