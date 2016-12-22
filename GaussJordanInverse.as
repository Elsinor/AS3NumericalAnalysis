package eu.elsinor.as3.NumericalAnalysis.NAMatrix 
{	
	import eu.elsinor.as3.math.EMatrix;
	public class GaussJordanInverse extends eu.elsinor.as3.math.EMatrix
	{
		//var inputMatrixSize: int;
		public function GaussJordanInverse(input: EMatrix)
		{
			//inputMatrixSize = input.rows;
			if (input.isSquare())
				algorithm(input);
		}
		
		private function algorithm(input: EMatrix): void
		{
			// (A|I)
			cloneFrom(mergeHorizontally(input, EMatrix.Identity(input.rows)));

			var L_i: EMatrix;
			Iterations: for (var it: int = 1; it <= input.rows; it++)
			{
				if (isPivotNotZero(this, it))
				{
					L_i = gaussJordanLower(this, it);
					trace("L_"+it+": "+L_i);
					trace("A^"+it+"|I^"+it+this);
					
					cloneFrom(EMatrix.multiply(L_i, this));
					
				} 
				else
					break Iterations;		
				trace("A^"+(it+1)+"|I^"+(it+1)+this);
			}
			
			// Divide rows by pivots
			for (var i: int = 1; i <= rows; i++)
				rowProduct(i, 1/getAt(i,i));
			
		}
		
		private function isPivotNotZero(input: EMatrix, i: int): Boolean
		{
			return input.getAt(i, i) != 0;
		}
		
		private function gaussJordanLower(input: EMatrix, j: int): EMatrix
		{
			var lower: EMatrix = EMatrix.Identity(input.rows);
			
			// (m_ij) = (input_ij) / (input_jj)
			for (var i: int = 1; i <= input.rows; i++)
				if (i != j)
				{
					lower.setAt(i, j, -input.getAt(i, j)/input.getAt(j, j));
				}
			return lower;
		}	
	}
}