
extern void _io_hlt(void);
extern void _write_mem8(int adr, int data);

void HariMain(void)
{
  int i;

  for (i = 0xa0000; i <= 0xaffff; i++) {
    _write_mem8(i, i & 0x0f); /* MOV BYTE [i],15; */
  }

  for (;;) {
		_io_hlt();
  }

}
