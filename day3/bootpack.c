
extern void _io_hlt(void);

void HariMain(void)
{

fin:
		/* ここにHLTを入れたいが，C言語ではHltが使えない！ */
		_io_hlt();
		goto fin;
}
