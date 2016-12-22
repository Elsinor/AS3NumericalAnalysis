# AS3NumericalAnalysis


Test with 7/20/16 ex. 2

import eu.elsinor.as3.math.EMatrix;
import eu.elsinor.as3.NumericalAnalysis.NAMatrix.GaussJordanInverse;

var matrix: EMatrix = new EMatrix(3, 3);
	  matrix.setAt(1, 1, 3);
	  matrix.setAt(1, 2, 2);
	  matrix.setAt(1, 3, 1);
	  matrix.setAt(2, 1, 4);
	  matrix.setAt(2, 2, 8);
	  matrix.setAt(2, 3, 1);
	  matrix.setAt(3, 1, 2);
	  matrix.setAt(3, 2, 1);
	  matrix.setAt(3, 3, 6);
trace("Input:"+matrix);

matrix = new GaussJordanInverse(matrix);
trace("Output:"+matrix);
