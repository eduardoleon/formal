/* Copyright (C) 2006 M. Ben-Ari */

class Count_l extends Thread {
  static volatile int n = 0;
  static int N;

  public void run() {
    int temp;
    for (int i = 0; i < N; i++) {
      temp = n; n = temp + 1;
      /* n++; */
    }
  }

  public static void main(String[] args) {
    if (args.length > 0) {
      try { N = Integer.parseInt(args[0]); }
      catch (NumberFormatException e) {
        System.err.println("Argument" + " must be an integer");
        System.exit(1);
      }
    }

    Count_l p = new Count_l();
    Count_l q = new Count_l();
    p.start();
    q.start();
    try { p.join(); q.join(); }
    catch (InterruptedException e) { }
    System.out.println(N + " + " + N + " = " + n);
  }
}
