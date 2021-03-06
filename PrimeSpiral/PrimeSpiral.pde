/*
  Ulam Spiral

  [説明]
  キャンバスの中心がスタート(自然数の1から)
  初期の移動量(move)は1
  moveだけ移動したら方向を反時計回りに90度転換して行く
  (Processingの場合は +x -y -x +y ... の順に移動する)
  2回方向転換するたびに移動量(move)が1増える

  [処理]
  移動するたびにnをインクリメント
  nとmoveが等しくなったら方向転換し,nをリセット
  方向転換するたびにcdをインクリメント
  2回方向転換したら(cd % 2 == 0ならば)moveをインクリメント
  cdが増えると移動方向は +x -y -x +y ... の順に変化
 */



int rectWidth = 10;
int rectHeight = rectWidth;
int iterations = 10000;



void setup()
{
  size(1000, 1000);
  background(0);
  noStroke();
  noLoop();
}



void draw()
{
  int currentX = floor(width/2);
  int currentY = floor(height/2);

  int n = 0;
  int cd = 0;
  int move = 1;

  for (int i = 1; i <= iterations; i++)
  {
    drawPrimeDot(currentX, currentY, i);

    // Drawing Spiral.
    // For more details, read a comment above.
    if (n == move)
    {
      n = 0;
      cd = (cd + 1) % 4;
      if (cd % 2 == 0) move++;
    }

    switch (cd)
    {
      case 0: currentX += rectWidth;  break; // Right
      case 1: currentY -= rectHeight; break; // Up
      case 2: currentX -= rectWidth;  break; // Left
      case 3: currentY += rectHeight; break; // Down
    }

    n++;
  }
}



void drawPrimeDot(int x, int y, int n)
{
  if      (n == 1)     fill(80);        // Gray
  else if (n == 2017)  fill(255, 0, 0); // Red
  else if (isPrime(n)) fill(255);       // White
  else return;

  rect(x, y, rectWidth, rectHeight);
}



boolean isPrime(int n)
{
  if (n <= 1) return false;

  // Simple Primality Test : O(√n)
  for (int i = 2; i <= sqrt(n); i++)
  {
    if (n % i == 0) return false;
  }

  return true;
}



void keyPressed()
{
  switch (key)
  {
    case 's':
      save("primeSpiral.png");
      println("Saved as 'primeSpiral.png'");
      break;

    case 'q':
      exit();
      break;
  }
}