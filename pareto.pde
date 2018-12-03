class ParetoSolution {
  int[][][] weight ;
  int[][][] weight1 ;
  PathVec[] pareto ;
  PathVecp[] pareto1 ;
  PathVecl[] labelpareto ;
  Vector singlelabel ;
   ParetoSolution(int[] m) {
    weight = instanceText(m) ;
    weight1 = instanceText1(m) ;
    // weight = randomWeight() ;
    pareto = new PathVec[nodenum] ;
    pareto1 = new PathVecp[nodenum] ;
    labelpareto = new PathVecl[nodenum] ;
    for(int j = 0 ; j < nodenum ; j++)  pareto[j] = new PathVec(j, weight[j]) ;
    for(int j = 0 ; j < nodenum ; j++)  pareto1[j] = new PathVecp(j, weight1[j]) ;
    for(int j = 0 ; j < nodenum ; j++)  labelpareto[j] = new PathVecl(j, weight1[j]) ;
    singlelabel = new Vector() ;
  }


  void labeling() {
   int time = Integer.MAX_VALUE ; ;
   for(int i = 0 ; i < experimentNum ; i++)
     time = min(time, labelingup()) ;
   println(lengl()+","+time) ;
  }
  int labelingup() {
    reset() ;
    int start = millis() ;
    labelpareto[0].add(new int[objective]) ;
    labelpareto[0].update = true ;
    boolean flag = true ;
    while(flag) {
      flag = false ;
      for(PathVecl ps : labelpareto) {
        for(PathVecl pps : labelpareto)
          if(ps.index != pps.index)
          if(ps.paretoConstruction(pps)) flag = true ;
        ps.update = true ;
      }
    }
    return millis() - start ;
  }


  void propose1() {
   int time = Integer.MAX_VALUE ; ;
   for(int i = 0 ; i < experimentNum ; i++)
     time = min(time, propose1up()) ;
   println(leng1()+","+time) ;
  }
  int propose1up() {
    reset() ;
    int start = millis() ;
    pareto1[0].add(new int[objective]) ;
    boolean flag = true ;
    while(flag) {
      flag = false ;
      for(PathVecp ps : pareto1) {
        for(PathVecp pps : pareto1)
          if(ps.index != pps.index)
          if(ps.paretoConstruction(pps)) flag = true ;
        ps.update() ;
      }
    }
    return millis() - start ;
  }


  void propose2() {
   int time = Integer.MAX_VALUE ; ;
   for(int i = 0 ; i < experimentNum ; i++)
     time = min(time, propose2up()) ;
   println(leng()+","+time) ;
  }
  int propose2up() {
    reset() ;
    int start = millis() ;
    pareto[0].upd.add(new Vector(new int[objective])) ;
    boolean flag = true ;
    while(flag) {
      flag = false ;
      for(PathVec ps : pareto)
        for(PathVec pps : pareto)
          if(ps.index != pps.index)
          if(ps.paretoConstruction(pps)) flag = true ;
      for(PathVec ps : pareto)
        ps.update() ;
    }
    return millis() - start ;
  }


  void reset() {
    for (PathVec vs : pareto)
      vs.reset() ;
    for (PathVecp vs : pareto1)
      vs.reset() ;
    for (PathVecl vs : labelpareto)
      vs.reset() ;
    singlelabel.clear() ;
  }
  int leng() {
    int count = 0 ;
    for(PathVec ps : pareto)
     count += ps.leng() ;
    return count ;
  }
  int leng1() {
    int count = 0 ;
    for(PathVecp ps : pareto1)
     count += ps.leng() ;
    return count ;
  }
  int lengl() {
    int count = 0 ;
    for(PathVecl ps : labelpareto)
     count += ps.leng() ;
    return count ;
  }


  int[][][] instanceText(int[] m) {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < m.length ; k++) {
      String[] lines = loadStrings(dir + "weight_" + nodenum + "_" + bound + "_" + m[k] + ".csv");
      for(int i = 0 ; i < nodenum ; i++){
        String[] values = split(lines[i], ",") ;
        for(int j = 0 ; j < nodenum ; j++) {
          weight[j][i][k] = int(values[j]) ;
        }
      }
    }
    return weight ;
  }
  int[][][] instanceText1(int[] m) {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < m.length ; k++) {
      String[] lines = loadStrings(dir + "weight_" + nodenum + "_" + bound + "_" + m[k] + ".csv");
      for(int i = 0 ; i < nodenum ; i++){
        String[] values = split(lines[i], ",") ;
        for(int j = 0 ; j < nodenum ; j++) {
          weight[i][j][k] = int(values[j]) ;
        }
      }
    }
    return weight ;
  }
  int[][][] randomWeight() {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < nodenum ; k++) {
      for(int i = 0 ; i < nodenum ; i++){
        for(int j = 0 ; j < objective; j++) {
          weight[k][i][j] = int(random(bound)) ;
        }
      }
    }
    return weight ;
  }
 }
