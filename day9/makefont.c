#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
	FILE *fp0, *fp1;
	if (argc < 3) {
		puts("usage>makefont source.txt font.bin");
		return 1;
	}
	fp0 = fopen(argv[1], "rb");
	fp1 = fopen(argv[2], "wb");
	if (fp0 == NULL) {
		puts("can't open input file.");
		return 2;
	}
	if (fp1 == NULL) {
		puts("can't open output file.");
		return 3;
	}

	char hankaku_head[] = "char hankaku[4096] = {\n";
	char kaigyou[] = "\n";
	char hankaku_tail[] = "};";
	int cnt = 0; // 16

	fwrite(hankaku_head, sizeof(char), strlen(hankaku_head), fp1);
	do {
		char s[12];
		char c[4*16];
		int i;
		if (fgets(s, 12, fp0) != NULL && (s[0] == ' ' || s[0] == '*' || s[0] == '.')) {
			//printf("%s",s);
			i  = (s[0] == '*') << 7;
			i |= (s[1] == '*') << 6;
			i |= (s[2] == '*') << 5;
			i |= (s[3] == '*') << 4;
			i |= (s[4] == '*') << 3;
			i |= (s[5] == '*') << 2;
			i |= (s[6] == '*') << 1;
			i |= (s[7] == '*')     ;
			//fputc(i, fp1);
			snprintf(c,16,"0x%02x,",i);
			//printf("%s",c);
			fwrite(c, sizeof(char), strlen(c), fp1);
			cnt++;
			if (cnt % 16 == 0) {
					cnt = 0;
					//printf("\n");
					fwrite(kaigyou, sizeof(char), strlen(kaigyou), fp1);
			}
		}
	} while (!feof(fp0));
	fwrite(hankaku_tail, sizeof(char), strlen(hankaku_tail), fp1);
	fclose(fp0);
	fclose(fp1);
	return 0;
}
