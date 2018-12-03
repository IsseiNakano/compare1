class Vectorp {
  int[] pathweight ;
  Vectorp pre ;
  Vectorp follow ;
  Vectorp() {
    pre = this ;
    follow = this ;
  }
  Vectorp(int[] weight) {
    pathweight = weight ;
  }
  void add(Vectorp a) {
    a.pre = this ;
    follow.pre = a ;
    a.follow = follow ;
    follow = a ;
  }
  void remove() {
    pre.follow = follow ;
    follow.pre = pre ;
  }
  void clear() {
    pre = this ;
    follow = this ;
  }
  boolean isEmpty(){
    return follow == this ;
  }
  void addAll(Vectorp a, Vectorp b) {
    pre.follow = a ;
    a.pre = pre ;
    pre = b ;
    b.follow = this ;
  }
  int[] calculation(int[] weight) {
    int[] value = new int[objective];
    for(int i = 0 ; i < objective ; i++)
      value[i] = pathweight[i] + weight[i] ;
    return value ;
  }
  int dominate(int[] u) {
    int status = 0 ;
    for (int k = 0 ; k < objective ; k++) {
      int d = u[k] - pathweight[k] ;
      if (d > 0) status |= 1 ;
      else if (d < 0) status |= 2 ;
      if (status == 3) break ;
    }
    return status ;
  }
}
 class PathVecp {
  Vectorp dummy ;
  int index ;
  int[][] w ;
  Vectorp upd ;
  PathVecp() {
  }
  PathVecp(int i, int[][] wei) {
    index = i ;
    w = wei ;
    dummy = new Vectorp() ;
    upd = dummy ;
  }
  void add(int[] wei) {
    dummy.pre.add(new Vectorp(wei)) ;
  }
  boolean paretoConstruction(PathVecp pps) {
    boolean flag = false ;
    for(Vectorp s = upd.follow ; s != dummy ; s = s.follow) {
      int[] path = s.calculation(w[pps.index]) ;
      if (pps.check(path)) {
        pps.add(path) ;
        flag = true ;
      }
    }
    return flag ;
  }
  int leng() {
    int count = 0 ;
    for(Vectorp s = dummy.follow ; s != dummy ; s = s.follow)
      count++ ;
    return count ;
  }
  boolean check(int[] u) {
    for (Vectorp v = dummy.follow ; v != dummy ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status <= 1) return false ;
      if (status == 2) {
        if(v == upd) upd = v.pre ;
        v.remove() ;
      }
    }
    return true ;
  }
  void update() {
    upd = dummy.pre ;
  }
  void reset() {
    dummy.clear() ;
    upd = dummy ;
  }
}
