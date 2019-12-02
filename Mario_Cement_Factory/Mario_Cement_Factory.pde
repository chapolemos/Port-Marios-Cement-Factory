/* Código do Port de Mario's Cement Factory, por Gustavo Lemos.
Feito em Processing3, baseado em máquinas de estado.
O código está todo comentado e organizado para mais fácil leitura.*/

//PImages do cenário e do game over.
PImage cenario, gameo;

//Estado Inicial das MEFs
boolean miss = false;
boolean gameover = false;
int score = 0;
int estadoCamEsq = 0;
int estadoCamDir = 0;
int estadoMiss = 0;
int estadoCimLEsq = 0;
int estadoCimLEsq2 = 0;
int estadoCimLDir = 0;
int estadoCimLDir2 = 0;
int estadoAlavEsq = 0;
int estadoAlavDir = 0;
int estadoCimEsq = 0;
int estadoCimDir = 0;
int estadoPlatEsq = 0;
int estadoPlatDir = 0;
int estadoMario = 0;

//Variável usada na scoreboard
String digito = "";

//Vetores de posicao do mario, imagem e de nome de imagem
PImage [] mariospr = new PImage [23];
String [] marioimg = new String [23];

//Vetores de posicao das plataformas, imagem e nome de imagens
PImage [] platspr = new PImage [8];
String [] platimg = new String [8];

//Vetores de posicao das caixas, imagem e nome de imagens
PImage [] caixspr = new PImage [18];
String [] caiximg = new String [18];

//Vetores de posicao das alavancas, imagem e nome de imagens
PImage [] alavspr = new PImage [7];
String [] alavimg = new String [7];

//Vetores de posicao dos cimentos, imagem e nome de imagens
PImage [] cimspr = new PImage [9];
String [] cimimg = new String [9];

//Vetores de posicao dos elementos da UI, imagem e nome de imagens
PImage [] uispr = new PImage [3];
String [] uiimg = new String [3];

//Vetores de posicao dos caminhoneiros, imagem e nome de imagens
PImage [] camspr = new PImage [10];
String [] camimg = new String [10];

//Vetores de posicao dos scores, imagem e nome de imagens
PImage [] scorespr = new PImage [99];
String [] scoreimg = new String [10];


//Timers de movimento e das plataformas
int timerMovimento = 6;
int timer = 1;
int timer2 = 31;

//Timers do cimento superior
int timerce = 1; 
int timercd = 31;

//Timers do cimento lateral
int timercle = 1;
int timercld = 31;

//Timers do cimento lateral sendo despejado
int timercle2 = 1;
int timercld2 = 31;

//Timers da sequencia de morte por escorregão
int timerqueda = 6;
int timerquedac = 6;

//Reset das alavancas
int resetalav = 6;


void setup() {
  frameRate(60);
  noStroke();
  size(1000, 640);
  //Loop de preenchimento dos vetores do mario
  for (int i=0; i<23; i++) {
    marioimg[i] = str(i)+".png";
    mariospr[i] = loadImage("Sprites/Mario/"+marioimg[i]);
  }
  //Loop de preenchimento dos vetores das plataformas
  for (int i=0; i<8; i++) {
    platimg[i] = str(i)+".png";
    platspr[i] = loadImage("Sprites/Cenario/Plataformas/"+platimg[i]);
  }
  //Loop de preenchimento dos vetores das caixas
  for (int i=0; i<18; i++) {
    caiximg[i] = str(i)+".png";
    caixspr[i] = loadImage("Sprites/Cenario/Caixas/"+caiximg[i]);
  }
  //Loop de preenchimento dos vetores das alavancas
  for (int i=0; i<7; i++) {
    alavimg[i] = str(i)+".png";
    alavspr[i] = loadImage("Sprites/Cenario/Alavancas/"+alavimg[i]);
  }
  //Loop de preenchimento dos vetores dos cimentos
  for (int i=0; i<9; i++) {
    cimimg[i] = str(i)+".png";
    cimspr[i] = loadImage("Sprites/Cenario/Cimentos/"+cimimg[i]);
  }
  //Loop de preenchimento dos vetores da UI
  for (int i=0; i<3; i++) {
    uiimg[i] = str(i)+".png";
    uispr[i] = loadImage("Sprites/UI/"+uiimg[i]);
  }
  //Loop de preenchimento dos vetores dos caminhoneiros
  for (int i=0; i<10; i++) {
    camimg[i] = str(i)+".png";
    camspr[i] = loadImage("Sprites/Caminhoneiros/"+camimg[i]);
  }
  //Loop de preenchimento dos vetores dos scores
  for (int i=0; i<10; i++) {
    scoreimg[i] = str(i)+".png";
    scorespr[i] = loadImage("Sprites/Score/"+scoreimg[i]);
  }
  //Cenario
  cenario = loadImage("Sprites/Cenario.png");
  gameo = loadImage("Sprites/UI/gameover.png");
}
void draw() {
  scale(4);
  textSize(10);
  background(255);
  //Texto Game A
  image(uispr[2], 165, 2);

  cimentos();
  image(cenario, 0, 0);
  mario();
  platdir();
  platesq();
  sobedesce();
  andaplataformas();
  caixas();
  alavancas();
  puxaalavanca();
  caicimento();
  miss();
  caminhoneiros();
  gameover();
  respawn();
  scoreboard();
  if (gameover) {
    gameoverscreen();
  }
  fill(0);
  textSize(6);
}

void andaplataformas() {
  //Andar de uma plataforma movel a outra
  //Topo
  if (estadoMario == 16 && estadoPlatDir == 1 && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    estadoMario = 17;
    timerMovimento = 6;
  }
  if (estadoMario == 17 && (estadoPlatEsq == 1 || estadoPlatEsq == 3)  && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    estadoMario = 16;
    timerMovimento = 6;
  }
  //Meio-topo
  if (estadoMario == 2 && estadoPlatDir == 0 && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    estadoMario = 3;
    timerMovimento = 6;
  }
  if (estadoMario == 3 && (estadoPlatEsq == 2 || estadoPlatEsq == 4) && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    estadoMario = 2;
    timerMovimento = 6;
  }
  //Meio-baixo
  if (estadoMario == 8 && estadoPlatDir == 1 && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    estadoMario = 9;
    timerMovimento = 6;
  }
  if (estadoMario == 9 && (estadoPlatEsq == 3 || estadoPlatEsq == 5) && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    estadoMario = 8;
    timerMovimento = 6;
  }
  //Baixo
  if (estadoMario == 18 && estadoPlatDir == 0 && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    estadoMario = 19;
    timerMovimento = 6;
  }
  if (estadoMario == 19 && (estadoPlatEsq == 0 || estadoPlatEsq == 4) && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    estadoMario = 18;
    timerMovimento = 6;
  }

  //Andar pelo game em geral
  //Plataforma central de cima
  //Esquerda pra direita
  if (estadoMario == 1 && (estadoPlatEsq == 2 || estadoPlatEsq == 4) && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    estadoMario = 2;
    timerMovimento = 6;
  }
  if (estadoMario == 2 && estadoPlatDir == 0 && keyPressed && keyCode == RIGHT & timerMovimento == 0) {  
    timerMovimento = 6;
    estadoMario = 3;
  }
  if (estadoMario == 3 && estadoPlatDir == 0 && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 4;
  }
  //Direita pra esquerda
  if (estadoMario == 4 && estadoPlatDir == 0 && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 3;
  }
  if (estadoMario == 3 && (estadoPlatEsq == 2 || estadoPlatEsq == 4) && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 2;
  }
  if (estadoMario == 2 && (estadoPlatEsq == 2 || estadoPlatEsq == 4) && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 1;
  }
  //Plataforma central de baixo
  //Esquerda pra direita
  if (estadoMario == 7 && (estadoPlatEsq == 3 || estadoPlatEsq == 5) && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    estadoMario = 8;
    timerMovimento = 6;
  }
  if (estadoMario == 8 && estadoPlatDir == 1 && keyPressed && keyCode == RIGHT & timerMovimento == 0) {  
    timerMovimento = 6;
    estadoMario = 9;
  }
  if (estadoMario == 9 && estadoPlatDir == 1 && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 10;
  }
  //Direita pra esquerda
  if (estadoMario == 10 && estadoPlatDir == 1 && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 9;
  }
  if (estadoMario == 9 && (estadoPlatEsq == 3 || estadoPlatEsq == 5) && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 8;
  }
  if (estadoMario == 8 && (estadoPlatEsq == 5 || estadoPlatEsq == 3) && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 7;
  }
  //Cantinho escuro lá de baixo if 0 e 4 esq
  if (estadoMario == 18 && (estadoPlatEsq == 0 || estadoPlatEsq == 4) && keyPressed && keyCode == LEFT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 20;
  }
  if (estadoMario == 20 && (estadoPlatEsq == 0 || estadoPlatEsq == 4) && keyPressed && keyCode == RIGHT & timerMovimento == 0) {
    timerMovimento = 6;
    estadoMario = 18;
  }
}


void sobedesce() {
  //Esta função existe pra controlar os movimentos das plataformas
  if (estadoMario == 18 && estadoPlatEsq == 0 && timer == 1)
    estadoMario = 22;

  if (estadoMario == 16 && estadoPlatEsq == 1 && timer == 1)
    estadoMario = 2;

  if (estadoMario == 2 && estadoPlatEsq == 2 && timer == 1)
    estadoMario = 8;

  if (estadoMario == 8 && estadoPlatEsq == 3 && timer == 1)
    estadoMario = 18;
  if (estadoMario == 16 && estadoPlatEsq == 3 && timer == 1)
    estadoMario = 2;

  if (estadoMario == 18 && estadoPlatEsq == 4 && timer == 1)
    estadoMario = 22;
  if (estadoMario == 2 && estadoPlatEsq == 4 && timer == 1)
    estadoMario = 8;

  if (estadoMario == 8 && estadoPlatEsq == 5 && timer == 1)
    estadoMario = 18;

  if (estadoMario == 19 && estadoPlatDir == 0 && timer2 == 1)
    estadoMario = 9;
  if (estadoMario == 9 && estadoPlatDir == 1 && timer2 == 1)
    estadoMario = 3;
  if (estadoMario == 3 && estadoPlatDir == 0 && timer2 == 1)
    estadoMario = 17;
  if (estadoMario == 17 && estadoPlatDir == 1 && timer2 == 1)
    estadoMario = 21;
}
void puxaalavanca() {
  resetalav--;
  //Reset das alavancas
  if (resetalav == 0) {
    estadoAlavEsq = 0;
    estadoAlavDir = 0;
  }
  //Cima-esquerda
  if (estadoMario == 12 && estadoAlavEsq == 0) {
    estadoAlavEsq = 1;
    resetalav = 10;
  }
  //Baixo-esquerda
  if (estadoMario == 14 && estadoAlavEsq == 0) {
    estadoAlavEsq = 2;
    resetalav = 10;
  }
  //Cima-esquerda
  if (estadoMario == 13 && estadoAlavDir == 0) {
    estadoAlavDir = 1;
    resetalav = 10;
  }
  //Baixo-direita
  if (estadoMario == 15 && estadoAlavDir == 0) {
    estadoAlavDir = 2;
    resetalav = 10;
  }
}

void caicimento() {
  timercle--;
  timercle2--;
  timercld--;
  timercld2--;
  //Cimento entrando na caixa de cima-esquerda
  if (estadoCimEsq == 8 && estadoCimLEsq == 0) {
    estadoCimLEsq = 1;
    timercle = 60;
  }
  if (estadoCimEsq == 8 && estadoCimLEsq == 2) {
    estadoCimLEsq = 7;
    timercle = 60;
  }
  if (estadoCimEsq == 8 && estadoCimLEsq == 3) {
    estadoCimLEsq = 4;
    timercle = 60;
  }
  if (estadoCimEsq == 8 && estadoCimLEsq == 5) {
    estadoCimLEsq = 6;
    timercle = 60;
  }
  if (estadoCimEsq == 8 && estadoCimLEsq == 8) {
    estadoCimLEsq = 9;
    timercle = 60;
  }
  if (estadoCimEsq == 8 && estadoCimLEsq == 10) {
    estadoCimLEsq = 11;
    timercle = 60;
  }
  //Abertura da caixa de cima-esquerda
  if (estadoCimLEsq == 3 && estadoAlavEsq == 1) {
    estadoCimLEsq = 8;
    timercle = 60;
  }
  if (estadoCimLEsq == 4 && estadoAlavEsq == 1) {
    estadoCimLEsq = 9;
    timercle = 60;
  }
  if (estadoCimLEsq == 5 && estadoAlavEsq == 1) {
    estadoCimLEsq = 10;
    timercle = 60;
  }
  if (estadoCimLEsq == 6 && estadoAlavEsq == 1) {
    estadoCimLEsq = 11;
    timercle = 60;
  }

  //Cimento entrando na caixa de baixo-esquerda
  if (estadoCimLEsq == 8 && timercle == 0 & estadoCimLEsq2 == 0) {
    estadoCimLEsq2 = 1;
  }
  if (estadoCimLEsq == 8 && timercle == 0 & estadoCimLEsq2 == 2) {
    estadoCimLEsq2 = 7;
  }
  if (estadoCimLEsq == 8 && timercle == 0 & estadoCimLEsq2 == 3) {
    estadoCimLEsq2 = 4;
  }
  if (estadoCimLEsq == 8 && timercle == 0 & estadoCimLEsq2 == 5) {
    estadoCimLEsq2 = 6;
  }

  if (estadoCimLEsq == 9 && timercle == 0 & estadoCimLEsq2 == 0) {
    estadoCimLEsq2 = 1;
  }
  if (estadoCimLEsq == 9 && timercle == 0 & estadoCimLEsq2 == 2) {
    estadoCimLEsq2 = 7;
  }
  if (estadoCimLEsq == 9 && timercle == 0 & estadoCimLEsq2 == 3) {
    estadoCimLEsq2 = 4;
  }
  if (estadoCimLEsq == 9 && timercle == 0 & estadoCimLEsq2 == 5) {
    estadoCimLEsq2 = 6;
  }

  if (estadoCimLEsq == 10 && timercle == 0 & estadoCimLEsq2 == 0) {
    estadoCimLEsq2 = 1;
  }
  if (estadoCimLEsq == 10 && timercle == 0 & estadoCimLEsq2 == 2) {
    estadoCimLEsq2 = 7;
  }
  if (estadoCimLEsq == 10 && timercle == 0 & estadoCimLEsq2 == 3) {
    estadoCimLEsq2 = 4;
  }
  if (estadoCimLEsq == 10 && timercle == 0 & estadoCimLEsq2 == 5) {
    estadoCimLEsq2 = 6;
  }

  if (estadoCimLEsq == 11 && timercle == 0 & estadoCimLEsq2 == 0) {
    estadoCimLEsq2 = 1;
  }
  if (estadoCimLEsq == 11 && timercle == 0 & estadoCimLEsq2 == 2) {
    estadoCimLEsq2 = 7;
  }
  if (estadoCimLEsq == 11 && timercle == 0 & estadoCimLEsq2 == 3) {
    estadoCimLEsq2 = 4;
  }
  if (estadoCimLEsq == 11 && timercle == 0 & estadoCimLEsq2 == 5) {
    estadoCimLEsq2 = 6;
  }
  //Abertura da caixa de baixo-esquerda
  if (estadoCimLEsq2 == 3 && estadoAlavEsq == 2) {
    estadoCimLEsq2 = 8;
    timercle2 = 60;
  }
  if (estadoCimLEsq2 == 4 && estadoAlavEsq == 2) {
    estadoCimLEsq2 = 9;
    timercle2 = 60;
  }
  if (estadoCimLEsq2 == 5 && estadoAlavEsq == 2) {
    estadoCimLEsq2 = 10;
    timercle2 = 60;
  }
  if (estadoCimLEsq2 == 6 && estadoAlavEsq == 2) {
    estadoCimLEsq2 = 11;
    timercle2 = 60;
  }
  //Cimento entrando na caixa de cima-direita
  if (estadoCimDir == 8 && estadoCimLDir == 0) {
    estadoCimLDir = 1;
    timercld = 60;
  }
  if (estadoCimDir == 8 && estadoCimLDir == 2) {
    estadoCimLDir = 7;
    timercld = 60;
  }
  if (estadoCimDir == 8 && estadoCimLDir == 3) {
    estadoCimLDir = 4;
    timercld = 60;
  }
  if (estadoCimDir == 8 && estadoCimLDir == 5) {
    estadoCimLDir = 6;
    timercld = 60;
  }
  if (estadoCimDir == 8 && estadoCimLDir == 8) {
    estadoCimLDir = 9;
    timercld = 60;
  }
  if (estadoCimDir == 8 && estadoCimLDir == 10) {
    estadoCimLDir = 11;
    timercld = 60;
  }
  //Abertura da caixa de cima-esquerda
  if (estadoCimLDir == 3 && estadoAlavDir == 1) {
    estadoCimLDir = 8;
    timercld = 60;
  }
  if (estadoCimLDir == 4 && estadoAlavDir == 1) {
    estadoCimLDir = 9;
    timercld = 60;
  }
  if (estadoCimLDir == 5 && estadoAlavDir == 1) {
    estadoCimLDir = 10;
    timercld = 60;
  }
  if (estadoCimLDir == 6 && estadoAlavDir == 1) {
    estadoCimLDir = 11;
    timercld = 60;
  }

  //Cimento entrando na caixa de baixo-direita
  if (estadoCimLDir == 8 && timercld == 0 & estadoCimLDir2 == 0) {
    estadoCimLDir2 = 1;
  }
  if (estadoCimLDir == 8 && timercld == 0 & estadoCimLDir2 == 2) {
    estadoCimLDir2 = 7;
  }
  if (estadoCimLDir == 8 && timercld == 0 & estadoCimLDir2 == 3) {
    estadoCimLDir2 = 4;
  }
  if (estadoCimLDir == 8 && timercld == 0 & estadoCimLDir2 == 5) {
    estadoCimLDir2 = 6;
  }

  if (estadoCimLDir == 9 && timercld == 0 & estadoCimLDir2 == 0) {
    estadoCimLDir2 = 1;
  }
  if (estadoCimLDir == 9 && timercld == 0 & estadoCimLDir2 == 2) {
    estadoCimLDir2 = 7;
  }
  if (estadoCimLDir == 9 && timercld == 0 & estadoCimLDir2 == 3) {
    estadoCimLDir2 = 4;
  }
  if (estadoCimLDir == 9 && timercld == 0 & estadoCimLDir2 == 5) {
    estadoCimLDir2 = 6;
  }

  if (estadoCimLDir == 10 && timercld == 0 & estadoCimLDir2 == 0) {
    estadoCimLDir2 = 1;
  }
  if (estadoCimLDir == 10 && timercld == 0 & estadoCimLDir2 == 2) {
    estadoCimLDir2 = 7;
  }
  if (estadoCimLDir == 10 && timercld == 0 & estadoCimLDir2 == 3) {
    estadoCimLDir2 = 4;
  }
  if (estadoCimLDir == 10 && timercld == 0 & estadoCimLDir2 == 5) {
    estadoCimLDir2 = 6;
  }

  if (estadoCimLDir == 11 && timercld == 0 & estadoCimLDir2 == 0) {
    estadoCimLDir2 = 1;
  }
  if (estadoCimLDir == 11 && timercld == 0 & estadoCimLDir2 == 2) {
    estadoCimLDir2 = 7;
  }
  if (estadoCimLDir == 11 && timercld == 0 & estadoCimLDir2 == 3) {
    estadoCimLDir2 = 4;
  }
  if (estadoCimLDir == 11 && timercld == 0 & estadoCimLDir2 == 5) {
    estadoCimLDir2 = 6;
  }
  //Abertura da caixa de baixo-direita
  if (estadoCimLDir2 == 3 && estadoAlavDir == 2) {
    estadoCimLDir2 = 8;
    timercld2 = 60;
  }
  if (estadoCimLDir2 == 4 && estadoAlavDir == 2) {
    estadoCimLDir2 = 9;
    timercld2 = 60;
  }
  if (estadoCimLDir2 == 5 && estadoAlavDir == 2) {
    estadoCimLDir2 = 10;
    timercld2 = 60;
  }
  if (estadoCimLDir2 == 6 && estadoAlavDir == 2) {
    estadoCimLDir2 = 11;
    timercld2 = 60;
  }
}

void scoreboard() {
  for (int i = 0; i< str(score).length(); i++) {
    digito = str((str(score)).charAt(i));
    image(scorespr[int(digito)], 60+(i*8), 8);
  }
}
//Respawn
int respawntimer = 1;
void respawn() {

  if (miss) {
    respawntimer--;
  }

  if (respawntimer == 0 && (estadoMario == 21 || estadoMario == 22)) {    
    miss = false;  
    estadoMario = 1;
    respawntimer = 120;
  }
  if (respawntimer == 0 && (estadoMario != 21 || estadoMario != 22)) {
    miss = false;
  }
}
//Fins de jogo
void gameover() {

  if (!miss) {
    //Teto e chão
    if (estadoMario == 21) {      
      estadoMiss++;      
      miss = true;
      respawntimer = 18;
    }
    if (estadoMario == 22) {      
      estadoMiss++;      
      miss = true;
      respawntimer = 18;
    }
    if (estadoCamEsq == 1 || estadoCamDir == 1) {
      estadoMiss++;
      miss = true;
      respawntimer = 64;
    }
    //Erros no cimento
    if (estadoCimEsq == 7 && estadoCimLEsq == 6) {           
      estadoCamEsq = 2;
    }
    if (estadoCimDir == 7 && estadoCimLDir == 6) {
      estadoCamDir = 2;
    }
    if ((estadoCimLEsq == 8 || estadoCimLEsq == 9 || estadoCimLEsq == 10 || estadoCimLEsq == 11) && estadoAlavEsq == 1 && estadoCimLEsq2 == 6) {
      estadoCamEsq = 3;
    }
    if ((estadoCimLDir == 8 || estadoCimLDir == 9 || estadoCimLDir == 10 || estadoCimLDir == 11) && estadoAlavDir == 1 && estadoCimLDir2 == 6) {
      estadoCamDir = 3;
    }

    //Caindo de plataformas
    //Coluna mais da esquerda
    if (estadoMario == 1 && keyPressed && keyCode == RIGHT && timerMovimento == 0 && (estadoPlatEsq != 2 || estadoPlatEsq != 4)) {
      estadoMario = 24;
    }
    if (estadoMario == 7 && keyPressed && keyCode == RIGHT && timerMovimento == 0 && (estadoPlatEsq != 3 || estadoPlatEsq != 5)) {
      estadoMario = 25;
    }
    if (estadoMario == 20 && keyPressed && keyCode == RIGHT && timerMovimento == 0 && (estadoPlatEsq != 0 || estadoPlatEsq != 4)) {
      estadoMario = 26;
    } 
    //Coluna centro esquerda
    if (estadoMario == 16 && keyPressed && keyCode == RIGHT && timerMovimento == 0 && estadoPlatDir != 1) {
      estadoMario = 27;
    }
    if (estadoMario == 2 && keyPressed && keyCode == RIGHT && timerMovimento == 0 && estadoPlatDir != 0) {
      estadoMario = 28;
    }
    if (estadoMario == 8 && keyPressed && keyCode == RIGHT && timerMovimento == 0 && estadoPlatDir != 1) {
      estadoMario = 29;
    }
    if (estadoMario == 18 && keyPressed && keyCode == RIGHT && timerMovimento == 0 && estadoPlatDir != 0) {
      estadoMario = 30;
    }
    //Coluna centro direita
    if (estadoMario == 17 && keyPressed && keyCode == LEFT && timerMovimento == 0 && (estadoPlatEsq != 3 || estadoPlatEsq != 5)) {
      estadoMario = 23;
    }
    if (estadoMario == 3 && keyPressed && keyCode == LEFT && timerMovimento == 0 && (estadoPlatEsq != 2 || estadoPlatEsq != 4)) {
      estadoMario = 24;
    }
    if (estadoMario == 9 && keyPressed && keyCode == LEFT && timerMovimento == 0 && (estadoPlatEsq != 3 || estadoPlatEsq != 5)) {
      estadoMario = 25;
    }
    if (estadoMario == 19 && keyPressed && keyCode == LEFT && timerMovimento == 0 && (estadoPlatEsq != 4 || estadoPlatEsq != 6)) {
      estadoMario = 26;
    }
    // Coluna mais da direita
    if (estadoMario == 4 && keyPressed && keyCode == LEFT && timerMovimento == 0 && estadoPlatDir != 0) {
      estadoMario = 28;
    }  
    if (estadoMario == 10 && keyPressed && keyCode == LEFT && timerMovimento == 0 && estadoPlatDir != 1) {
      estadoMario = 29;
    }
  }
  if ((miss && estadoMario == 21 || estadoMario == 22))
    delay(150);
  // if ((miss && estadoCamEsq == 1 || estadoCamDir == 1))
  //delay(80);
}
//MEF DOS CAMINHONEIROS
void caminhoneiros() {


  if (estadoCamEsq == 0) {
    image(camspr[0], 35, 120);
  }
  //Camesq morto
  if (estadoCamEsq == 1) {
    image(camspr[1], 35, 135);
    timerquedac--;
    if (timerquedac==0) {
      estadoCamEsq = 0;
      timerquedac = 6;
    }
  }
  if (estadoCamDir == 0) {
    image(camspr[2], 193, 120);
  }
  //Camdir morto
  if (estadoCamDir == 1) {
    image(camspr[3], 168, 135);
    timerquedac--;
    if (timerquedac==0) {
      estadoCamDir = 0;
      timerquedac = 6;
    }
  }
  //Cimento caindo esquerda
  if (estadoCamEsq == 2) {
    image(camspr[0], 35, 120);
    image(camspr[4], 37, 53);
    timerquedac--;
    if (timerquedac==0) {
      estadoCamEsq = 3;
      timerquedac = 6;
    }
  }
  if (estadoCamEsq == 3) {
    image(camspr[0], 35, 120);
    image(camspr[5], 37, 83);
    timerquedac--;
    if (timerquedac==0) {
      estadoCamEsq = 4;
      timerquedac = 6;
    }
  }
  if (estadoCamEsq == 4) {
    image(camspr[0], 35, 120);
    image(camspr[6], 37, 113);
    timerquedac--;
    if (timerquedac==0) {
      estadoCamEsq = 1;
      timerquedac = 36;
    }
  }

  //Cimento caindo direita
  if (estadoCamDir == 2) {
    image(camspr[2], 193, 120);
    image(camspr[7], 203, 53);
    timerquedac--;
    if (timerquedac==0) {
      estadoCamDir = 3;
      timerquedac = 6;
    }
  }
  if (estadoCamDir == 3) {
    image(camspr[2], 193, 120);
    image(camspr[8], 203, 83);
    timerquedac--;
    if (timerquedac==0) {
      estadoCamDir = 4;
      timerquedac = 6;
    }
  }
  if (estadoCamDir == 4) {
    image(camspr[2], 193, 120);
    image(camspr[9], 193, 113);
    timerquedac--;
    if (timerquedac==0) {
      estadoCamDir = 1;
      timerquedac = 36;
    }
  }
}
//MEF DO MISS
void miss() {

  if (estadoMiss == 0) {
  }
  if (estadoMiss == 1) {
    image(uispr[1], 215, 16);
    image(uispr[0], 235, 2);
  }
  if (estadoMiss == 2) {
    image(uispr[1], 215, 16);
    image(uispr[0], 220, 2);
    image(uispr[0], 235, 2);
  }
  if (estadoMiss == 3) {
    image(uispr[1], 215, 16);
    image(uispr[0], 205, 2);
    image(uispr[0], 220, 2);
    image(uispr[0], 235, 2);
    gameover = true;
  }
}
//MEF DOS CIMENTOS NA LATERAL
void cimentos() {
  //estadoCimLEsq2 = 6;
  //Caixa da esquerda de cima
  if (estadoCimLEsq == 0) {
  }

  if (estadoCimLEsq == 1) {
    image(cimspr[1], 6, 50);
    if (timercle == 0) {
      estadoCimLEsq = 2;
      timercle = 60;
    }
  }
  if (estadoCimLEsq == 2) {
    image(cimspr[2], 6, 50);
    if (timercle == 0) {
      estadoCimLEsq = 3;
      timercle = 60;
    }
  }
  if (estadoCimLEsq == 3) {
    image(cimspr[3], 6, 50);
  }
  if (estadoCimLEsq == 4) {
    image(cimspr[4], 6, 50);
    if (timercle == 0) {
      estadoCimLEsq = 5;
      timercle = 60;
    }
  }
  if (estadoCimLEsq == 5) {
    image(cimspr[5], 6, 50);
  }
  if (estadoCimLEsq == 6) {
    image(cimspr[6], 6, 50);
  }
  if (estadoCimLEsq == 7) {
    image(cimspr[7], 6, 50);
    if (timercle == 0) {
      estadoCimLEsq = 5;
      timercle = 60;
    }
  }

  //Estados do cimento caindo por baixo da caixa de cima-esquerda
  if (estadoCimLEsq == 8) {
    image(cimspr[8], 16, 80);
    if (timercle == 0) {
      estadoCimLEsq = 0;    
      timercle = 60;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq == 9) {
    image(cimspr[1], 6, 50);
    image(cimspr[8], 16, 80);
    if (timercle == 0) {
      estadoCimLEsq = 2;     
      timercle = 60;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq == 10) {
    image(cimspr[2], 6, 50);
    image(cimspr[8], 16, 80);
    if (timercle == 0) {
      estadoCimLEsq = 3;  
      timercle = 60;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq == 11) {
    image(cimspr[7], 6, 50);
    image(cimspr[8], 16, 80);
    if (timercle == 0) {
      estadoCimLEsq = 5;
      timercle = 60;
      timercle2 = 60;
    }
  }
  //Estados da caixa de baixo-esquerda
  if (estadoCimLEsq2 == 0) {
  }

  if (estadoCimLEsq2 == 1) {
    image(cimspr[1], 6, 83);
    if (timercle2 == 0) {
      estadoCimLEsq2 = 2;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq2 == 2) {
    image(cimspr[2], 6, 83);
    if (timercle2 == 0) {
      estadoCimLEsq2 = 3;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq2 == 3) {
    image(cimspr[3], 6, 83);
  }
  if (estadoCimLEsq2 == 4) {
    image(cimspr[4], 6, 83);
    if (timercle2 == 0) {
      estadoCimLEsq2 = 5;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq2 == 5) {
    image(cimspr[5], 6, 83);
  }
  if (estadoCimLEsq2 == 6) {
    image(cimspr[6], 6, 83);
  }
  if (estadoCimLEsq2 == 7) {
    image(cimspr[7], 6, 83);
    if (timercle2 == 0) {
      estadoCimLEsq2 = 5;
      timercle2 = 60;
    }
  }

  //Estado do cimento caindo por baixo da caixa de baixo-esquerda
  if (estadoCimLEsq2 == 8) {
    image(cimspr[8], 16, 113);
    if (timercle2 == 0) {
      estadoCimLEsq2 = 0;
      score++;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq2 == 9) {
    image(cimspr[1], 6, 83);
    image(cimspr[8], 16, 113);
    if (timercle2 == 0) {
      estadoCimLEsq2 = 2;
      score++;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq2 == 10) {
    image(cimspr[2], 6, 83);
    image(cimspr[8], 16, 113);
    if (timercle2 == 0) {
      estadoCimLEsq2 = 3;
      score++;
      timercle2 = 60;
    }
  }
  if (estadoCimLEsq2 == 11) {
    image(cimspr[7], 6, 83);
    image(cimspr[8], 16, 113);
    if (timercle2 == 0) {
      estadoCimLEsq2 = 5;
      score++;
      timercle2 = 60;
    }
  }
  //Caixa da direita de cima   
  if (estadoCimLDir == 0) {
  }

  if (estadoCimLDir == 1) {
    image(cimspr[1], 209, 50);
    if (timercld == 0) {
      estadoCimLDir = 2;
      timercld = 60;
    }
  }
  if (estadoCimLDir == 2) {
    image(cimspr[2], 209, 50);
    if (timercld == 0) {
      estadoCimLDir = 3;
      timercld = 60;
    }
  }
  if (estadoCimLDir == 3) {
    image(cimspr[3], 209, 50);
  }
  if (estadoCimLDir == 4) {
    image(cimspr[4], 209, 50);
    if (timercld == 0) {
      estadoCimLDir = 5;
      timercld = 60;
    }
  }
  if (estadoCimLDir == 5) {
    image(cimspr[5], 209, 50);
  }
  if (estadoCimLDir == 6) {
    image(cimspr[6], 209, 50);
  }
  if (estadoCimLDir == 7) {
    image(cimspr[7], 209, 50);
    if (timercld == 0) {
      estadoCimLDir = 5;
      timercld = 60;
    }
  }
  //Estados do cimento caindo por baixo da caixa de cima-direita
  if (estadoCimLDir == 8) {
    image(cimspr[8], 219, 80);
    if (timercld == 0) {
      estadoCimLDir = 0;    
      timercld = 60;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir == 9) {
    image(cimspr[1], 209, 50);
    image(cimspr[8], 219, 80);
    if (timercld == 0) {
      estadoCimLDir = 2;     
      timercld = 60;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir == 10) {
    image(cimspr[2], 209, 50);
    image(cimspr[8], 219, 80);
    if (timercld == 0) {
      estadoCimLDir = 3;  
      timercld = 60;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir == 11) {
    image(cimspr[7], 209, 50);
    image(cimspr[8], 219, 80);
    if (timercld == 0) {
      estadoCimLDir = 5;
      timercld = 60;
      timercld2 = 60;
    }
  }
  //Estados da caixa de baixo-direita
  if (estadoCimLDir2 == 0) {
  }

  if (estadoCimLDir2 == 1) {
    image(cimspr[1], 209, 83);
    if (timercld2 == 0) {
      estadoCimLDir2 = 2;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir2 == 2) {
    image(cimspr[2], 209, 83);
    if (timercld2 == 0) {
      estadoCimLDir2 = 3;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir2 == 3) {
    image(cimspr[3], 209, 83);
  }
  if (estadoCimLDir2 == 4) {
    image(cimspr[4], 209, 83);
    if (timercld2 == 0) {
      estadoCimLDir2 = 5;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir2 == 5) {
    image(cimspr[5], 209, 83);
  }
  if (estadoCimLDir2 == 6) {
    image(cimspr[6], 209, 83);
  }
  if (estadoCimLDir2 == 7) {
    image(cimspr[7], 209, 83);
    if (timercld2 == 0) {
      estadoCimLDir2 = 5;
      timercld2 = 60;
    }
  }

  //Estado do cimento caindo por baixo da caixa de baixo-direita
  if (estadoCimLDir2 == 8) {
    image(cimspr[8], 219, 113);
    if (timercld2 == 0) {
      estadoCimLDir2 = 0;
      score++;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir2 == 9) {
    image(cimspr[1], 209, 83);
    image(cimspr[8], 219, 113);
    if (timercld2 == 0) {
      estadoCimLDir2 = 2;
      score++;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir2 == 10) {
    image(cimspr[2], 209, 83);
    image(cimspr[8], 219, 113);
    if (timercld2 == 0) {
      estadoCimLDir2 = 3;
      score++;
      timercld2 = 60;
    }
  }
  if (estadoCimLDir2 == 11) {
    image(cimspr[7], 209, 83);
    image(cimspr[8], 219, 113);
    if (timercld2 == 0) {
      estadoCimLDir2 = 5;
      score++;
      timercld2 = 60;
    }
  }
}
//MEF DAS ALAVANCAS
void alavancas() {
  if (estadoAlavEsq == 0) {
    image(alavspr[0], 38, 67);
    image(alavspr[0], 38, 99);

    image(alavspr[4], 18, 75);
    image(alavspr[4], 18, 108);
  }
  if (estadoAlavEsq == 1) {
    image(alavspr[1], 38, 73);
    image(alavspr[0], 38, 99);

    image(alavspr[5], 7, 78);
    image(alavspr[4], 18, 108);
  }
  if (estadoAlavEsq == 2) {
    image(alavspr[0], 38, 67);
    image(alavspr[1], 38, 105);

    image(alavspr[4], 18, 75);
    image(alavspr[5], 7, 110);
  }

  //Direitas
  if (estadoAlavDir == 0) {
    image(alavspr[2], 201, 67);
    image(alavspr[2], 201, 99);
    //Portinhola
    image(alavspr[4], 221, 75);
    image(alavspr[4], 221, 108);
  }
  if (estadoAlavDir == 1) {
    image(alavspr[3], 199, 73);
    image(alavspr[2], 201, 99);

    image(alavspr[6], 233, 78);
    image(alavspr[4], 221, 108);
  }
  if (estadoAlavDir == 2) {
    image(alavspr[2], 201, 67);
    image(alavspr[3], 199, 105);

    image(alavspr[4], 221, 75);
    image(alavspr[6], 233, 111);
  }
}

//MEF DAS CAIXAS DE CIMENTO DA LATERAL
//MEF DAS CAIXAS DE CIMENTO DE CIMA
void caixas() {
  timercd--;
  timerce--;
  //Caixas do lado esquerdo
  if (estadoCimEsq == 0) {
    image(caixspr[9], 1, 18);
    if (timerce == 0) {
      timerce = 60;
      estadoCimEsq = 1;
    }
  }

  if (estadoCimEsq == 1) {
    image(caixspr[10], 1, 18);
    if (timerce == 0) {
      timerce = 60;
      estadoCimEsq = 2;
    }
  }

  if (estadoCimEsq == 2) {
    image(caixspr[11], 1, 18);
    if (timerce == 0) {
      timerce = 60;
      estadoCimEsq = 3;
    }
  }

  if (estadoCimEsq == 3) {
    image(caixspr[12], 1, 18);
    if (timerce == 0) {
      timerce = 60;
      estadoCimEsq = 4;
    }
  }

  if (estadoCimEsq == 4) {
    image(caixspr[13], 1, 18);
    if (timerce == 0) {
      timerce = 15;
      estadoCimEsq = 5;
    }
  }

  if (estadoCimEsq == 5) {
    image(caixspr[14], 2, 18);
    if (timerce == 0) {
      timerce = 15;
      estadoCimEsq = 6;
    }
  }

  if (estadoCimEsq == 6) {
    image(caixspr[15], 7, 23);
    if (timerce == 0) {
      timerce = 15;
      estadoCimEsq = 7;
    }
  }
  if (estadoCimEsq == 7) {
    image(caixspr[16], 7, 24);
    if (timerce == 0) {
      timerce = 15;
      estadoCimEsq = 8;
    }
  }
  if (estadoCimEsq == 8) {
    image(caixspr[17], 7, 24);
    if (timerce == 0) {
      timerce = 60;
      estadoCimEsq = 0;
    }
  }
  //Caixas do lado direito

  if (estadoCimDir == 0) {
    image(caixspr[0], 167, 24);
    if (timercd == 0) {
      timercd = 60;
      estadoCimDir = 1;
    }
  }

  if (estadoCimDir == 1) {
    image(caixspr[1], 167, 24);
    if (timercd == 0) {
      timercd = 60;
      estadoCimDir = 2;
    }
  }

  if (estadoCimDir == 2) {
    image(caixspr[2], 167, 24);
    if (timercd == 0) {
      timercd = 60;
      estadoCimDir = 3;
    }
  }

  if (estadoCimDir == 3) {
    image(caixspr[3], 167, 24);
    if (timercd == 0) {
      timercd = 60;
      estadoCimDir = 4;
    }
  }

  if (estadoCimDir == 4) {
    image(caixspr[4], 167, 24);
    if (timercd == 0) {
      timercd = 15;
      estadoCimDir = 5;
    }
  }

  if (estadoCimDir == 5) {
    image(caixspr[5], 167, 24);
    if (timercd == 0) {
      timercd = 15;
      estadoCimDir = 6;
    }
  }

  if (estadoCimDir == 6) {
    image(caixspr[6], 160, 24);
    if (timercd == 0) {
      timercd = 15;
      estadoCimDir = 7;
    }
  }
  if (estadoCimDir == 7) {
    image(caixspr[7], 160, 24);
    if (timercd == 0) {
      timercd = 15;
      estadoCimDir = 8;
    }
  }
  if (estadoCimDir == 8) {
    image(caixspr[8], 160, 24);
    if (timercd == 0) {
      timercd = 60;
      estadoCimDir = 0;
    }
  }
  //Chave final abaixo.
}

//MEF DAS PLATAFORMAS
void platesq() {
  if (estadoPlatEsq == 0) {
    image(platspr[2], 99, 20);
    if (timer == 0) {
      estadoPlatEsq = 1;
      timer = 60;
    }
  }

  if (estadoPlatEsq == 1) {
    image(platspr[3], 99, 20);
    if (timer == 0) {
      estadoPlatEsq = 2;
      timer = 60;
    }
  }
  if (estadoPlatEsq == 2) {
    image(platspr[4], 99, 20);
    if (timer == 0) {
      estadoPlatEsq = 3;
      timer = 60;
    }
  }
  if (estadoPlatEsq == 3) {
    image(platspr[5], 99, 20);
    if (timer == 0) {
      estadoPlatEsq = 4;
      timer = 60;
    }
  }
  if (estadoPlatEsq == 4) {
    image(platspr[6], 99, 20);
    if (timer == 0) {
      estadoPlatEsq = 5;
      timer = 60;
    }
  }
  if (estadoPlatEsq == 5) {
    image(platspr[7], 99, 20);
    if (timer == 0) {
      estadoPlatEsq = 0;
      timer = 60;
    }
  }
}

void platdir() {
  if (estadoPlatDir == 0) {
    image(platspr[0], 126, 20);
    if (timer2 == 0) {
      estadoPlatDir = 1;
      timer2 = 60;
    }
  }
  if (estadoPlatDir == 1) {
    image(platspr[1], 126, 20);
    if (timer2 == 0) {
      estadoPlatDir = 0;
      timer2 = 60;
    }
  }
}
//MEF DO MARIO
void mario() {
  //Timers
  //Variável para que o jogador não mova-se rápido demais
  timerMovimento--;
  timer--;
  timer2--;
  //lembra de deletar isso e colocar nos estados, aqui fora nao funciona
  if (timerMovimento <= 0)
    timerMovimento = 0;

  //Movimento
  if (estadoMario == 0) {
    image(mariospr[0], 50, 55);
    if (timerMovimento == 0) {
      if (keyPressed) {
        if (keyCode == RIGHT) {
          estadoMario = 1;
          timerMovimento = 6;
        }
        if (keyCode == LEFT) {
          estadoMario = 12;
          timerMovimento = 6;
        }
      }
    }
  }
  if (estadoMario == 1) {
    image(mariospr[1], 75, 55);
    if (timerMovimento == 0) {
      if (keyPressed) {
        if (keyCode == LEFT) {
          estadoMario = 0;
          timerMovimento = 6;
        }
      }
    }
  }
  if (estadoMario == 2) {
    image(mariospr[2], 100, 55);
  }
  if (estadoMario == 3) {
    image(mariospr[3], 128, 55);
  }
  if (estadoMario == 4) {
    image(mariospr[4], 150, 56);
    if (timerMovimento == 0) {
      if (keyPressed) {
        if (keyCode == RIGHT) {
          estadoMario = 5;
          timerMovimento = 6;
        }
      }
    }
  }
  if (estadoMario == 5) {
    image(mariospr[5], 175, 55);
    if (timerMovimento == 0) {
      if (keyPressed) {
        if (keyCode == LEFT) {
          estadoMario = 4;
          timerMovimento = 6;
        }
        if (keyCode == RIGHT) {
          estadoMario = 13;
          timerMovimento = 6;
        }
      }
    }
  }

  //Plataformas de baixo

  if (estadoMario == 6) {
    image(mariospr[6], 50, 83);
    if (timerMovimento == 0) {
      if (keyPressed) {
        if (keyCode == RIGHT) {
          estadoMario = 7;
          timerMovimento = 6;
        }
        if (keyCode == LEFT) {
          estadoMario = 14;
          timerMovimento = 6;
        }
      }
    }
  }
  if (estadoMario == 7) {
    image(mariospr[7], 75, 83);
    if (timerMovimento == 0) {
      if (keyPressed) {

        if (keyCode == LEFT) {
          estadoMario = 6;
          timerMovimento = 6;
        }
      }
    }
  }
  if (estadoMario == 8) {
    image(mariospr[8], 100, 84);
  }
  if (estadoMario == 9) {
    image(mariospr[9], 128, 84);
  }
  if (estadoMario == 10) {
    image(mariospr[10], 150, 82);
    if (timerMovimento == 0) {
      if (keyPressed) {
        if (keyCode == RIGHT) {
          estadoMario = 11;
          timerMovimento = 6;
        }
      }
    }
  }
  if (estadoMario == 11) {
    image(mariospr[11], 175, 84);
    if (timerMovimento == 0) {
      if (keyPressed) {
        if (keyCode == LEFT) {
          estadoMario = 10;
          timerMovimento = 6;
        }
        if (keyCode == RIGHT) {
          estadoMario = 15;
          timerMovimento = 6;
        }
      }
    }
  }
  if (estadoMario == 12) {
    image(mariospr[12], 54, 55);
    if (timerMovimento == 0) {
      estadoMario = 0;
      timerMovimento = 6;
    }
  }
  if (estadoMario == 13) {
    image(mariospr[13], 175, 55);
    if (timerMovimento == 0) {
      estadoMario = 5;
      timerMovimento = 6;
    }
  }
  if (estadoMario == 14) {
    image(mariospr[14], 51, 83);
    if (timerMovimento == 0) {
      estadoMario = 6;
      timerMovimento = 6;
    }
  }
  if (estadoMario == 15) {
    image(mariospr[15], 175, 84);
    if (timerMovimento == 0) {
      estadoMario = 11;
      timerMovimento = 6;
    }
  }
  if (estadoMario == 16) {
    image(mariospr[16], 100, 26);
  }
  if (estadoMario == 17) {
    image(mariospr[17], 125, 26);
  }
  if (estadoMario == 18) {
    image(mariospr[18], 100, 115);
  }
  if (estadoMario == 19) {
    image(mariospr[19], 125, 115);
  }
  if (estadoMario == 20) {
    image(mariospr[20], 75, 110);
  }
  if (estadoMario == 21) {
    image(mariospr[21], 100, 5);
  }
  if (estadoMario == 22) {
    image(mariospr[22], 97, 140);
  }
  //Caindo pra morte
  //Queda esquerda
  if (estadoMario == 23) {
    image(mariospr[16], 100, 26);
    timerqueda--;
    if (timerqueda==0) {
      estadoMario = 24;
      timerqueda = 6;
    }
  }
  if (estadoMario == 24) {
    image(mariospr[2], 100, 55);
    timerqueda--;
    if (timerqueda==0) {
      estadoMario = 25;
      timerqueda = 6;
    }
  }
  if (estadoMario == 25) {
    image(mariospr[8], 100, 84);
    timerqueda--;
    if (timerqueda==0) {
      estadoMario = 26;
      timerqueda = 6;
    }
  }
  if (estadoMario == 26) {
    image(mariospr[18], 100, 115);
    timerqueda--;
    if (timerqueda==0) {
      estadoMario = 22;
      timerqueda = 6;
    }
  }
  //Queda direita
  if (estadoMario == 27) {
    image(mariospr[17], 125, 26);
    timerqueda--;
    if (timerqueda==0) {
      estadoMario = 28;
      timerqueda = 6;
    }
  }
  if (estadoMario == 28) {
    image(mariospr[3], 128, 55);
    timerqueda--;
    if (timerqueda==0) {
      estadoMario = 29;
      timerqueda = 6;
    }
  }
  if (estadoMario == 29) {
    image(mariospr[9], 128, 84);
    timerqueda--;
    if (timerqueda==0) {
      estadoMario = 30;
      timerqueda = 6;
    }
  }
  if (estadoMario == 30) {
    image(mariospr[19], 125, 115);
    timerqueda--;
    if (timerqueda==0) {
      estadoMario = 22;
      timerqueda = 6;
    }
  }
}
//Tela de game over
void gameoverscreen() {
  background(255);
  image(uispr[2], 165, 2);
  image(cenario, 0, 0);
  image(mariospr[0], 50, 55);
  image(mariospr[1], 75, 55);
  image(mariospr[2], 100, 55);
  image(mariospr[3], 128, 55);
  image(mariospr[4], 150, 56);
  image(mariospr[5], 175, 55);
  image(mariospr[6], 50, 83);
  image(mariospr[7], 75, 83);
  image(mariospr[8], 100, 84);
  image(mariospr[9], 128, 84);
  image(mariospr[10], 150, 82);
  image(mariospr[11], 175, 84);
  image(mariospr[12], 54, 55);
  image(mariospr[13], 175, 55);
  image(mariospr[14], 51, 83);
  image(mariospr[15], 175, 84);
  image(mariospr[16], 100, 26);
  image(mariospr[17], 125, 26);
  image(mariospr[18], 100, 115);
  image(mariospr[19], 125, 115);
  image(mariospr[20], 75, 110);
  image(mariospr[21], 100, 5);
  image(mariospr[22], 97, 140);
  image(camspr[0], 35, 120);
  image(camspr[1], 35, 135);
  image(camspr[2], 193, 120);
  image(camspr[3], 168, 135);
  image(camspr[4], 37, 53);
  image(camspr[5], 37, 83);
  image(camspr[6], 37, 113);
  image(camspr[7], 203, 53);
  image(camspr[8], 203, 83);
  image(camspr[9], 193, 113);
  image(uispr[1], 215, 16);
  image(uispr[0], 205, 2);
  image(uispr[0], 220, 2);
  image(uispr[0], 235, 2);
  image(cimspr[6], 6, 50);
  image(cimspr[8], 16, 80);
  image(cimspr[6], 6, 83);
  image(cimspr[8], 16, 113);
  image(cimspr[6], 209, 50);
  image(cimspr[8], 219, 80);
  image(cimspr[6], 209, 83);
  image(cimspr[8], 219, 113);
  image(alavspr[0], 38, 67);
  image(alavspr[0], 38, 99);
  image(alavspr[4], 18, 75);
  image(alavspr[4], 18, 108);
  image(alavspr[1], 38, 73);
  image(alavspr[0], 38, 99);
  image(alavspr[4], 18, 75);
  image(alavspr[5], 7, 110);
  image(caixspr[9], 1, 18);
  image(caixspr[10], 1, 18);
  image(caixspr[11], 1, 18);
  image(caixspr[12], 1, 18);
  image(caixspr[13], 1, 18);
  image(caixspr[14], 2, 18);
  image(caixspr[15], 7, 23);
  image(caixspr[16], 7, 24);
  image(caixspr[17], 7, 24);
  image(caixspr[0], 167, 24);
  image(caixspr[1], 167, 24);
  image(caixspr[2], 167, 24);
  image(caixspr[3], 167, 24);
  image(caixspr[4], 167, 24);
  image(caixspr[5], 167, 24);
  image(caixspr[6], 160, 24);
  image(caixspr[7], 160, 24);
  image(caixspr[8], 160, 24);
  fill (100, 0, 0);
  image(gameo, 37, 60);
  fill(255);
  text(score, 157, 96);
  image(scorespr[9], 60, 8);
  image(scorespr[9], 68, 8);
  image(scorespr[9], 76, 8);
}
//Fim do código 
//AGORA TERMINOU MESMO
