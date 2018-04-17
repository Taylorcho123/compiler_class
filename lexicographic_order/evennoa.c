#include <stdio.h>
#include <string.h>

void error_message(void)
{
    printf("이 문자열에는  Σ={a,b,c} 이외의 알파벳이 포함되어 있습니다.\n");
    printf("다시 입력해주세요.\n");
}

int error_check(char* isit_L)
{
    char acc[4]={97,98,99,10};
    int ch;

    // 엡실론
    if(isit_L[0] == ' ' && strlen(isit_L) == 1) {
	return 0;
    }
    else {
	for(int offset=0; offset<strlen(isit_L); offset++){
	    ch=0;
	    for(int alp=0; alp<4; alp++){
		if(isit_L[offset] == acc[alp]) {
		    ch++;
		}
	    }
	    if(ch == 0){
		error_message();
		return 1;
	    }
	}
    }
    return 0;
}

int read_n_check(char* tobe)
{
    unsigned int no_a=0;

    for(int offset=0; offset<strlen(tobe); offset++){
	if(tobe[offset] == 'a') {
	    no_a++;
	}
    }

    return no_a;
}

int main(void)
{
    char input_str[10000]={0};
    unsigned int no_a = 0;

    /* Ctrl + D = EOF in Linux system. */
    while(fgets(input_str, sizeof(input_str), stdin) != NULL)
    {
	/* 문자열에서 fgets로 입력된 개행문자 제거 */
	input_str[strlen(input_str)-1] = input_str[strlen(input_str)];

	if(error_check(input_str)) {
	    continue;
	}

	if(read_n_check(input_str)%2 == 0) {
	    printf("accept: %s\n", input_str);
	}
	else {    
	    printf("reject: %s\n", input_str);
	}
	fflush(stdin);
    }

    return 0;
}
