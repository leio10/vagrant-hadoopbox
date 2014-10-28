package mahout;

import java.io.*;
import java.util.*; 

import org.apache.mahout.cf.taste.common.*;
import org.apache.mahout.cf.taste.recommender.*;
import org.apache.mahout.cf.taste.model.*;
import org.apache.mahout.cf.taste.eval.*;
import org.apache.mahout.cf.taste.neighborhood.*;
import org.apache.mahout.cf.taste.similarity.*;

import org.apache.mahout.cf.taste.impl.recommender.*;
import org.apache.mahout.cf.taste.impl.neighborhood.*;
import org.apache.mahout.cf.taste.impl.model.file.*;
import org.apache.mahout.cf.taste.impl.eval.*;
import org.apache.mahout.cf.taste.impl.similarity.*;

class SampleRecommender
{
    public static void main(String[] args) throws TasteException, IOException {
        DataModel model = new FileDataModel(new File(args[0]));
        UserSimilarity similarity = new PearsonCorrelationSimilarity(model);
        UserNeighborhood neighborhood = new ThresholdUserNeighborhood(0.1, similarity, model);
        UserBasedRecommender recommender = new GenericUserBasedRecommender(model, neighborhood, similarity);
        List<RecommendedItem> recommendations = recommender.recommend(Integer.parseInt(args[1]), 4);
        for (RecommendedItem recommendation : recommendations) {
          System.out.print(recommendation.getItemID());
          System.out.print(", ");
        }
        System.out.println();

        for (RecommendedItem recommendation : recommendations) {
          System.out.print(recommendation.getValue());
          System.out.print(", "); 
        }
    }
}
