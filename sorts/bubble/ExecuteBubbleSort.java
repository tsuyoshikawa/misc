import java.io.*;

public class ExecuteBubbleSort {

    // このソースコードはマジで酷いので、参考にしちゃ駄目だよ！
    public static void main (String[] args) {

        // 1000しかないので、ハードコード
        int ary[] = new int[1000] ;

        try{
            FileReader fr = new FileReader("data.txt");
            BufferedReader br = new BufferedReader( fr ) ;
            String tmp_str ;

            int i = 0 ;

            while( (tmp_str = br.readLine()) != null ) {
                int tmp = Integer.parseInt( tmp_str ) ;
                ary[i] = tmp ;
                i++ ;
            }

            sort( ary );

            for(i = 0; i < ary.length ; i++){
                System.out.println( ary[i] );
            }
        }
        catch(IOException e){
            e.printStackTrace();
            System.exit(1);
        }
    }

    // バブルソートのアルゴリズム
    private static void sort(int[] ary) {

        //別にローカル変数にしなくていいけど
        int elt_maxi = ary.length - 1 ;

        for(int i = 0; i < elt_maxi; i++){

            for(int j = elt_maxi; j > i; j--){

                if(ary[j] < ary[j-1]){
                    // いっこ前の要素とスワップする
                    int tmp = ary[j] ;
                    ary[j] = ary[j-1];
                    ary[j-1] = tmp;
                }
            }
        }
    }

}