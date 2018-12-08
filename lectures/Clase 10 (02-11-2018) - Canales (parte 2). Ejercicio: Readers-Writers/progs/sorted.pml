chan ch = [3] of { byte };

inline getValue() {
  if
  :: n = 1
  :: n = 2
  :: n = 3
  fi
}

active proctype Sort() {
  byte n;
  getValue(); ch !! n;
  getValue(); ch !! n;
  getValue(); ch !! n;
  ch ? n; printf("%d\n", n);
  ch ? n; printf("%d\n", n);
  ch ? n; printf("%d\n", n)
}
