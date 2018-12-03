class PathVecl {
 Vectorp dummy ;
 int index ;
 int[][] w ;
 boolean update ;
 PathVecl() {
 }
 PathVecl(int i, int[][] wei) {
   index = i ;
   w = wei ;
   dummy = new Vectorp() ;
 }
 void add(int[] wei) {
   dummy.pre.add(new Vectorp(wei)) ;
 }
 boolean paretoConstruction(PathVecl pps) {
   if(!update) return false ;
   boolean flag = false ;
   for(Vectorp s = dummy.follow ; s != dummy ; s = s.follow) {
     int[] path = s.calculation(w[pps.index]) ;
     if (pps.check(path)) {
       pps.add(path) ;
       pps.update = true ;
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
     if (status == 2)
       v.remove() ;
   }
   return true ;
 }
 void reset() {
   dummy.clear() ;
 }
}
