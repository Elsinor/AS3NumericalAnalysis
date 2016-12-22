package eu.elsinor.as3.math 
{	
	public class EMatrix 
	{
		public var rows: int;
		public var columns: int;
		
		var elements: Array;
		
		// ! var nDecimals: int;
		public function EMatrix(rows: int = 1, columns: int = 1) 
		{
			this.rows = rows;
			this.columns = columns;			
			
			instantiateMatrix();
		}

		// Utility function
		function instantiateMatrix(): void
		{
			elements = new Array(rows);
			for (var i: int = 0; i < rows; i++)
				elements[i] = new Array(columns);			
		}
		
		public function setAt(i: int, j: int, value: Number): void
		{
			if (isIndexValid(i, j))
				elements[i - 1][j - 1] = value;
			else 
				trace("inValid!");
		}
		
		public function getAt(i: int, j: int): Number
		{
			if (isIndexValid(i, j))
				return elements[i - 1][j - 1];
			return undefined;
		}
		
		public function rowProduct(row: int, scalar: Number): void
		{
			for (var j: int = 1; j <= columns; j++)
				setAt(row, j, getAt(row, j) * scalar)			
		}
		
		public function isSquare(): Boolean
		{
			return rows == columns;
		}
		
		public function cloneFrom(input: EMatrix): void
		{
			rows = input.rows;
			columns = input.columns;
			
			instantiateMatrix();
			for (var i: int = 1; i <= input.rows; i++)
				for (var j: int = 1; j <= input.columns; j++)
					setAt(i, j, input.getAt(i, j));
		}
		
		public function toString(): String
		{
			var matrix: String = "\n";
			
			for (var i: int = 1; i <= rows; i++)
			{
				for (var j: int = 1; j <= columns; j++)
				{
					if (j == 1)
						matrix += "[";
					matrix += String(getAt(i, j));
					if (j != columns)
						matrix += ",";
					else 
						matrix += "]";
				}
				
				if (i != rows)
					matrix += "\n";
			}
			return matrix;
		}
		
		
		/* 	<!- Static Functions 
			< begin */
		
		// Returns Identity matrix
		public static function Identity(size: int): EMatrix
		{
			var identity: EMatrix = ZeroMatrix(size);
			for (var i: int = 1; i <= size; i++)
					identity.setAt(i, i, 1);
			return identity;
		}
		
		// Returns Zero matrix
		public static function ZeroMatrix(size: int): EMatrix
		{
			var zero: EMatrix = new EMatrix(size, size);
			for (var i: int = 1; i <= size; i++)
				for (var j: int = 1; j <= size; j++)
					zero.setAt(i, j, 0);
			return zero;			
		}
		
		public static function multiply(inputM1, inputM2): EMatrix
		{
			var product: EMatrix = new EMatrix(inputM1.rows, inputM2.columns);
			var sum: Number = 0;
			for (var i: int = 1; i <= inputM1.rows; i++)
				for (var j: int = 1; j <= inputM2.columns; j++)
				{
				   for (var k: int = 1; k <= inputM2.rows; k++)
					  sum = sum + inputM1.getAt(i, k) * inputM2.getAt(k, j);

				   product.setAt(i, j, sum);
				   sum = 0;
				}
			return product;			
		}
		
		public static function mergeHorizontally(inputM1, inputM2): EMatrix
		{
			var merged: EMatrix = new EMatrix(inputM1.rows, inputM1.columns + inputM2.columns);
				merged.setAt(1, 5, 99);
			var i: int;
			var j: int;
			
			for (i = 1; i <= inputM1.rows; i++)
				for (j = 1; j <= inputM1.columns; j++)
					merged.setAt(i, j, inputM1.getAt(i, j));			
			var k: int;
			var w: int;
						
			for (k = 1, i = 1; k <= inputM2.rows; k++, i++)
			{
				j = inputM1.columns + 1;
				for (w = 1; w <= inputM2.columns; w++, j++)
					merged.setAt(i, j, inputM2.getAt(k, w));					
			}
			
			return merged;
		}
		/* 	Static Functions -!>
			> end */
					
		private function isIndexValid(i: int, j: int): Boolean
		{
			return i > 0 && i <= rows && j > 0 && j <= columns;
		}		
	}	
}
