
extern void _io_hlt(void);
extern void _write_mem8(int adr, int data);

void HariMain(void)
{
  int i;
  char *p;

  for (i = 0xa0000; i <= 0xaffff; i++) {

    p = (char *) i;

    *p = i & 0x0f;

	/* OR
	 * *(p + i) = i & 0x0f;
	 * OR
	 * p[i] = i & 0x0f;
	 */

  }

  for (;;) {
		_io_hlt();
  }

}
