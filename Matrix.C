#include<stdio.h>
#include<conio.h>
#include <stdlib.h>

typedef struct Matrix{
    int **matrix;
    int row,col;
}Matrix;

Matrix Create()
{

    Matrix m;
    int i,j;
    printf("Enter the no.of row and columns:");
    scanf("%d %d",&m.row,&m.col);

       m.matrix=(int**)malloc(m.row * sizeof(int*));
    
     for (i = 0; i < m.row; i++)
     {
         m.matrix[i]=(int *)malloc(m.col * sizeof(int));
     }
    
    printf("Enter  Value Of Matrix:\n");
    for (i = 0; i < m.row;i++)
    {
        for (j = 0; j < m.col; j++)
        {
            scanf("%d",&m.matrix[i][j]);
        }
  }
   return m;
}

void Print(Matrix *m)
{
    int i,j;
	for(i=0;i<m->row;i++)
    {
	for(j=0;j<m->col;j++)
	{
	    printf("%d ",m->matrix[i][j]);
	}
	printf("\n");
    }
}


void MatrixAddition(Matrix *m,Matrix *n)
{
    int i,j;
    
    if(m->row==n->row && m->col==n->col)
    {
        for (i = 0; i < m->row; i++)
        {
            for (j = 0; j< m->col; j++)
            {
                printf(" %d ",(m->matrix[i][j]+n->matrix[i][j]));            
	    }
	    printf("\n");
	}


    }
    else
    {
	printf("\nMatrix Addition is not posible because both matrix are not have same no of rows and column.\n");
    }


}


void MatrixSubtraction(Matrix *m,Matrix *n)
{
    int i,j;

    if(m->row==n->row && m->col==n->col)
    {
	for (i = 0; i < m->row; i++)
	{
	    for (j = 0; j< m->col; j++)
	    {
		printf(" %d ",(m->matrix[i][j]-n->matrix[i][j]));
	    }
	    printf("\n");
	}


    }
    else
    {
	printf("\nMatrix Subtraction is not posible because both matrix are not have same no of rows and column.\n");
    }


}




Matrix Transpose(Matrix *m)
{
    int i,j,k;
    Matrix mt;
    mt.row=m->col;
    mt.col=m->row;


     mt.matrix=(int**)malloc(mt.row * sizeof(int*));
    
     for (i = 0; i < mt.row; i++)
     {
	     mt.matrix[i]=(int *)malloc(mt.col * sizeof(int));
     }

    for(i=0;i<m->row;++i)
    {
            for (j = 0;j<m->col;++j)
            {
                mt.matrix[j][i]=m->matrix[i][j];
                
            }
            
    }
    return mt;

}

int Equal(Matrix *m,Matrix *n)
{
   int i,j;  
    for(i=0;i<m->row;i++)
    {
		for(j=0;j<m->col;j++)
        {
            if(m->matrix[i][j]!=n->matrix[i][j])
			    return 1;
        }
        
	} 
    return 0;
}

void Multiplication(Matrix *m,Matrix *n)
{
    int i,j,k,sum=0;
    
    Matrix mul;
    mul.row=m->row;
    mul.col=n->col;
   
    
     mul.matrix=(int**)malloc(mul.row * sizeof(int*));
    
     for (i = 0; i < mul.row; i++)
     {
         mul.matrix[i]=(int *)malloc(mul.col * sizeof(int));
     }

    if(m->col != n->row)
    {
         printf("Matrix Multiplication is not possibale first matrix row and second matrix columns are not same.");
    }
    else
    {
         for (i = 0;i<m->row;i++)
         { 
             for (j = 0;j<m->col;j++)
             { 
                 for (k = 0;k<n->row;k++)
                 {
                        sum+=m->matrix[i][k]*n->matrix[k][j];
                            
                 }
                
                 mul.matrix[i][j]=sum;
                 printf("%d ",mul.matrix[i][j]);
                 sum=0;
                }
             printf("\n");
         }
         
         
    }
    
    
    
}

int main()
{
    Matrix A,B,AT;
     printf("Creating Matrix A:\n");
    A=Create();
    printf("Creating Matrix B:\n");
    B=Create();
    printf("\nA+B\n");
    MatrixAddition(&A,&B);
    printf("\nA-B\n");
    MatrixSubtraction(&A,&B);
    printf("Transpose of Matrix A:\n");
    AT=Transpose(&A);
    Print(&AT);
    getch();
	return 0;
}
