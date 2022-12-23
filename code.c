#include <stdio.h>

void fillB(int *A, int *B, int n, int *cnt)
{
    // Проходимся по всем элементам массива A, и сохраняем в B все индексы положительных элементов массива.
    for (int i = 0; i < n; ++i) {
        if (A[i] > 0) {
            B[*cnt] = i;
            ++(*cnt);
        }
    }
}

static void printArr(FILE *out, int *arr, int n)
{
    for (int i = 0; i < n; ++i)
    {
        fprintf(out, "%d ", arr[i]);
    }
}

static void fillArr(FILE *in, int *arr, int n)
{
    for (int i = 0; i < n; ++i)
    {
        fscanf(in, "%d", &arr[i]);
    }
}

int main()
{
    // Заранее выделяем место под массив A и B.
    int A[100], B[100];
    int n, i;
    
    // Открываем файлы.
    FILE *in = fopen("input.txt", "r");
    FILE *out = fopen("output.txt", "w");
    
    fscanf(in, "%d", &n);
    
    // Считываем массив A.
    fillArr(in, A, n);
    
    int cnt = 0;
    fillB(A, B, n, &cnt);
    
    // Выводим полученный массив B.
    printArr(out, B, cnt);
    return 0;
}

