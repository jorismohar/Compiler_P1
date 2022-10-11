%{
    
    #include <iostream>

    using namespace std;
    string lexema;

    void erro( string std ){
        cout << "Erro: Identificador inválido: " << std << endl;
    }
    void strprint1(string lexema){
        string std = lexema.c_str();
        cout << "265 " << std.substr( 1, std.length() - 2) << endl;
    }
    void strprint2(string lexema){
        string std = lexema.c_str();
        cout << "266 " << std.substr( 1, std.length() - 2) << endl;
    }
    void exprprint(string lexema){
        string std = lexema.c_str();
        cout << "268 " << std.substr( 1, std.length() - 1) << endl;
    }
%}
/* Coloque aqui definições regulares */
D	        [0-9]
L	        [A-Za-z_]
FE          ({L}|{D}|"@"|_)

WS	        [ \t\n]
ID          ($|_|{L})({L}|{D}|_|"@"({L}|{D}|"@")|({L}|{D}|"@")"@")*
IF          (i|I)(f|F)
FOR         (f|F)(o|O)(r|R)
INT         {D}+
FLOAT       {INT}("."{INT})?([Ee]("+"|"-")?{INT})?
STRING      ((\"([^"]|(\\\")|(\"\"))*\")|(\'([^']|(\\\')|(\'\'))*\'))
COMENTARIO  ("//".*|"/*"([^*]|(\n)|(\*([^/]|[\n])))*"*/")
STRING2     ("`"([^$]|\n|("$"([^{]|[\n])))*"`"|"`"([^$]|\n)*\$|\}([^$]|\n)*"`")
EXPR        (\{{ID}) 
ERRO        (($|{L}|{D}|"@"|_)*@{FE}*|$?{FE}*($)+{FE}*)

/**/
%% /* */
    /* Padrões e ações. Nesta seção, comentários devem ter um tab antes */

{WS}	        { /* ignora espaços, tabs e '\n' */ }
{IF}            {lexema = yytext; return _IF; }
{FOR}           {lexema = yytext; return _FOR; }
{INT}           {lexema = yytext; return _INT; }
{ID}            {lexema = yytext; return _ID; }
{STRING}        {lexema = yytext; strprint1(lexema);}
{STRING2}       {lexema = yytext; strprint2(lexema);}
{COMENTARIO}    {lexema = yytext; return _COMENTARIO;}
{FLOAT}         {lexema = yytext; return _FLOAT; }
{EXPR}          {lexema = yytext; exprprint(lexema);}
">="            {lexema = yytext; return _MAIG; }
"<="            {lexema = yytext; return _MEIG; }
"=="            {lexema = yytext; return _IG; }
"!="            {lexema = yytext; return _DIF; }
{ERRO}          {lexema = yytext; erro(lexema);}
.               {lexema = yytext; return *yytext; }
          /* Essa deve ser a última regra. Dessa forma qualquer caractere isolado será retornado pelo seu código ascii. */ 

%%

/* Não coloque nada aqui - a função main é automaticamente incluída na hora de avaliar e dar a nota. */