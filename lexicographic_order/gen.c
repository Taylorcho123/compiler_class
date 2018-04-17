#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

void print_error(void)
{
    printf("잘못 입력 하셨습니다.\n\n");
    printf("사용법 : \n");
    printf("$ gen [자연수]\n");
    printf("gen 프로그램의 옵션의 개수는 1개여야 합니다.\n");
}

void init_word(int len, char* str) 
{
    int init;

    if(len == 0){
	strcpy(str, " ");
    }
    else {
	for(init=0; init < len; init++){
	    str[init] = 'a';
	}
	str[init]='\0';
    }
}

void add_one_operation(int len, char* str){
    int inv=len-1;

    str[inv]++;
    for(inv=len-1; inv>=0; inv--){
	if(str[inv]>='d'){
	    str[inv]='a';
	    str[inv-1]++;   // 자릿수 받아올림.
	}
    }
}

int main(int argc, char* argv[])
{
    char *strnum;
    int alpha_len;
    const int num_of_alpha = 3;

    /* 예외 처리 
     아규먼트 개수는 반드시 1개여야 한다. */
    if(argc == 1 || argc > 2) {
	print_error();
	exit(1);  // 강제 종료
    }
    else {
	alpha_len=atoi(argv[1]);
	strnum=(char*)malloc(sizeof(char)*(alpha_len+1));
    }

    for(int i=0; i<=alpha_len; i++){
	init_word(i, strnum);
	printf("%s\n", strnum);
	
	/* for 조건문에서의 루프는 알파벳의 개수와 문자열의 길이의 거듭제곱에서,
	   반드시 -1을 빼준 값만큼 돌아야 한다.
	   빼주지 않는다면, add_one_operation()에서 문자열의 자릿수가 올라가기 때문에
	   잘못된 값을 참조하게 되기 때문이다. */
	for(int j=0; j<((int)pow((double)num_of_alpha, (double)i))-1; j++){
	    add_one_operation(i, strnum);
	    printf("%s\n", strnum);
	}
    }

    return 0;
}

