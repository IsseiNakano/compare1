// 完全グラフのためグラフを使用していない（頂点はint:頂点数nの時０ 〜 n-1）
//dijkstra：拡張ダイクストラ
//polynomial：完全多項式近似スキーム
//labeling：ラベル付けアルゴリズム
//propose1：提案解法１
//propose2：提案解法２
String dir = "/Users/nakano/Desktop/instanceData/" ;
String dirF = "/Users/nakano/Desktop/data500/" ;
final int nodenum = 500 ;
final int bound = 300 ;
final int objective = 3 ;
final int experimentNum = 10 ;
final int maxint = 99999 ;
boolean negativeobj[] = new boolean[objective] ;
int inpath = 0 ;

void setup() {
// dir = "../../data/" ;
  int[] m = {0,1,2} ;
  ParetoSolution p = new ParetoSolution(m) ;
  // p.dijkstra() ;
  // p.polynomial() ;
  // p.labeling() ;
  p.propose1() ;
  p.propose2() ;
  exit() ;
}
