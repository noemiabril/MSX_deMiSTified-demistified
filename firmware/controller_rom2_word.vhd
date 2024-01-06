library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic	(
	ADDR_WIDTH : integer := 8; -- ROM's address width (words, not bytes)
	COL_WIDTH  : integer := 8;  -- Column width (8bit -> byte)
	NB_COL     : integer := 4  -- Number of columns in memory
	);
port (
	clk : in std_logic;
	reset_n : in std_logic := '1';
	addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
	q : out std_logic_vector(31 downto 0);
	-- Allow writes - defaults supplied to simplify projects that don't need to write.
	d : in std_logic_vector(31 downto 0) := X"00000000";
	we : in std_logic := '0';
	bytesel : in std_logic_vector(3 downto 0) := "1111"
);
end entity;

architecture arch of controller_rom2 is

-- type word_t is std_logic_vector(31 downto 0);
type ram_type is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(NB_COL * COL_WIDTH - 1 downto 0);

signal ram : ram_type :=
(

     0 => x"00080c06",
     1 => x"80808080",
     2 => x"00808080",
     3 => x"03000000",
     4 => x"00000407",
     5 => x"54742000",
     6 => x"00787c54",
     7 => x"447f7f00",
     8 => x"00387c44",
     9 => x"447c3800",
    10 => x"00004444",
    11 => x"447c3800",
    12 => x"007f7f44",
    13 => x"547c3800",
    14 => x"00185c54",
    15 => x"7f7e0400",
    16 => x"00000505",
    17 => x"a4bc1800",
    18 => x"007cfca4",
    19 => x"047f7f00",
    20 => x"00787c04",
    21 => x"3d000000",
    22 => x"0000407d",
    23 => x"80808000",
    24 => x"00007dfd",
    25 => x"107f7f00",
    26 => x"00446c38",
    27 => x"3f000000",
    28 => x"0000407f",
    29 => x"180c7c7c",
    30 => x"00787c0c",
    31 => x"047c7c00",
    32 => x"00787c04",
    33 => x"447c3800",
    34 => x"00387c44",
    35 => x"24fcfc00",
    36 => x"00183c24",
    37 => x"243c1800",
    38 => x"00fcfc24",
    39 => x"047c7c00",
    40 => x"00080c04",
    41 => x"545c4800",
    42 => x"00207454",
    43 => x"7f3f0400",
    44 => x"00004444",
    45 => x"407c3c00",
    46 => x"007c7c40",
    47 => x"603c1c00",
    48 => x"001c3c60",
    49 => x"30607c3c",
    50 => x"003c7c60",
    51 => x"10386c44",
    52 => x"00446c38",
    53 => x"e0bc1c00",
    54 => x"001c3c60",
    55 => x"74644400",
    56 => x"00444c5c",
    57 => x"3e080800",
    58 => x"00414177",
    59 => x"7f000000",
    60 => x"0000007f",
    61 => x"77414100",
    62 => x"0008083e",
    63 => x"03010102",
    64 => x"00010202",
    65 => x"7f7f7f7f",
    66 => x"007f7f7f",
    67 => x"1c1c0808",
    68 => x"7f7f3e3e",
    69 => x"3e3e7f7f",
    70 => x"08081c1c",
    71 => x"7c181000",
    72 => x"0010187c",
    73 => x"7c301000",
    74 => x"0010307c",
    75 => x"60603010",
    76 => x"00061e78",
    77 => x"183c6642",
    78 => x"0042663c",
    79 => x"c26a3878",
    80 => x"00386cc6",
    81 => x"60000060",
    82 => x"00600000",
    83 => x"5c5b5e0e",
    84 => x"711e0e5d",
    85 => x"fef3c24c",
    86 => x"4bc04dbf",
    87 => x"ab741ec0",
    88 => x"c487c702",
    89 => x"78c048a6",
    90 => x"a6c487c5",
    91 => x"c478c148",
    92 => x"49731e66",
    93 => x"c887dfee",
    94 => x"49e0c086",
    95 => x"c487efef",
    96 => x"496a4aa5",
    97 => x"f187f0f0",
    98 => x"85cb87c6",
    99 => x"b7c883c1",
   100 => x"c7ff04ab",
   101 => x"4d262687",
   102 => x"4b264c26",
   103 => x"711e4f26",
   104 => x"c2f4c24a",
   105 => x"c2f4c25a",
   106 => x"4978c748",
   107 => x"2687ddfe",
   108 => x"1e731e4f",
   109 => x"b7c04a71",
   110 => x"87d303aa",
   111 => x"bfc2d4c2",
   112 => x"c187c405",
   113 => x"c087c24b",
   114 => x"c6d4c24b",
   115 => x"c287c45b",
   116 => x"c25ac6d4",
   117 => x"4abfc2d4",
   118 => x"c0c19ac1",
   119 => x"e8ec49a2",
   120 => x"c248fc87",
   121 => x"78bfc2d4",
   122 => x"1e87effe",
   123 => x"66c44a71",
   124 => x"e949721e",
   125 => x"262687f5",
   126 => x"d4c21e4f",
   127 => x"e649bfc2",
   128 => x"f3c287cf",
   129 => x"bfe848f6",
   130 => x"f2f3c278",
   131 => x"78bfec48",
   132 => x"bff6f3c2",
   133 => x"ffc3494a",
   134 => x"2ab7c899",
   135 => x"b0714872",
   136 => x"58fef3c2",
   137 => x"5e0e4f26",
   138 => x"0e5d5c5b",
   139 => x"c8ff4b71",
   140 => x"f1f3c287",
   141 => x"7350c048",
   142 => x"87f5e549",
   143 => x"c24c4970",
   144 => x"49eecb9c",
   145 => x"7087c3cb",
   146 => x"f3c24d49",
   147 => x"05bf97f1",
   148 => x"d087e2c1",
   149 => x"f3c24966",
   150 => x"0599bffa",
   151 => x"66d487d6",
   152 => x"f2f3c249",
   153 => x"cb0599bf",
   154 => x"e5497387",
   155 => x"987087c3",
   156 => x"87c1c102",
   157 => x"c0fe4cc1",
   158 => x"ca497587",
   159 => x"987087d8",
   160 => x"c287c602",
   161 => x"c148f1f3",
   162 => x"f1f3c250",
   163 => x"c005bf97",
   164 => x"f3c287e3",
   165 => x"d049bffa",
   166 => x"ff059966",
   167 => x"f3c287d6",
   168 => x"d449bff2",
   169 => x"ff059966",
   170 => x"497387ca",
   171 => x"7087c2e4",
   172 => x"fffe0598",
   173 => x"fb487487",
   174 => x"5e0e87dc",
   175 => x"0e5d5c5b",
   176 => x"4dc086f4",
   177 => x"7ebfec4c",
   178 => x"c248a6c4",
   179 => x"78bffef3",
   180 => x"1ec01ec1",
   181 => x"cdfd49c7",
   182 => x"7086c887",
   183 => x"87cd0298",
   184 => x"ccfb49ff",
   185 => x"49dac187",
   186 => x"c187c6e3",
   187 => x"f1f3c24d",
   188 => x"c302bf97",
   189 => x"87c3d587",
   190 => x"bff6f3c2",
   191 => x"c2d4c24b",
   192 => x"e9c005bf",
   193 => x"49fdc387",
   194 => x"c387e6e2",
   195 => x"e0e249fa",
   196 => x"c3497387",
   197 => x"1e7199ff",
   198 => x"cefb49c0",
   199 => x"c8497387",
   200 => x"1e7129b7",
   201 => x"c2fb49c1",
   202 => x"c586c887",
   203 => x"f3c287fa",
   204 => x"9b4bbffa",
   205 => x"c287dd02",
   206 => x"49bffed3",
   207 => x"7087d7c7",
   208 => x"87c40598",
   209 => x"87d24bc0",
   210 => x"c649e0c2",
   211 => x"d4c287fc",
   212 => x"87c658c2",
   213 => x"48fed3c2",
   214 => x"497378c0",
   215 => x"cd0599c2",
   216 => x"49ebc387",
   217 => x"7087cae1",
   218 => x"0299c249",
   219 => x"4cfb87c2",
   220 => x"99c14973",
   221 => x"c387cd05",
   222 => x"f4e049f4",
   223 => x"c2497087",
   224 => x"87c20299",
   225 => x"49734cfa",
   226 => x"cd0599c8",
   227 => x"49f5c387",
   228 => x"7087dee0",
   229 => x"0299c249",
   230 => x"f4c287d4",
   231 => x"c902bfc2",
   232 => x"88c14887",
   233 => x"58c6f4c2",
   234 => x"4cff87c2",
   235 => x"49734dc1",
   236 => x"ce0599c4",
   237 => x"49f2c387",
   238 => x"87f5dfff",
   239 => x"99c24970",
   240 => x"c287db02",
   241 => x"7ebfc2f4",
   242 => x"a8b7c748",
   243 => x"6e87cb03",
   244 => x"c280c148",
   245 => x"c058c6f4",
   246 => x"4cfe87c2",
   247 => x"fdc34dc1",
   248 => x"ccdfff49",
   249 => x"c2497087",
   250 => x"87d50299",
   251 => x"bfc2f4c2",
   252 => x"87c9c002",
   253 => x"48c2f4c2",
   254 => x"c2c078c0",
   255 => x"c14cfd87",
   256 => x"49fac34d",
   257 => x"87e9deff",
   258 => x"99c24970",
   259 => x"c287d902",
   260 => x"48bfc2f4",
   261 => x"03a8b7c7",
   262 => x"c287c9c0",
   263 => x"c748c2f4",
   264 => x"87c2c078",
   265 => x"4dc14cfc",
   266 => x"03acb7c0",
   267 => x"c487d1c0",
   268 => x"d8c14a66",
   269 => x"c0026a82",
   270 => x"4b6a87c6",
   271 => x"0f734974",
   272 => x"f0c31ec0",
   273 => x"49dac11e",
   274 => x"c887dbf7",
   275 => x"02987086",
   276 => x"c887e2c0",
   277 => x"f4c248a6",
   278 => x"c878bfc2",
   279 => x"91cb4966",
   280 => x"714866c4",
   281 => x"6e7e7080",
   282 => x"c8c002bf",
   283 => x"4bbf6e87",
   284 => x"734966c8",
   285 => x"029d750f",
   286 => x"c287c8c0",
   287 => x"49bfc2f4",
   288 => x"c287c9f3",
   289 => x"02bfc6d4",
   290 => x"4987ddc0",
   291 => x"7087c7c2",
   292 => x"d3c00298",
   293 => x"c2f4c287",
   294 => x"eff249bf",
   295 => x"f449c087",
   296 => x"d4c287cf",
   297 => x"78c048c6",
   298 => x"e9f38ef4",
   299 => x"5b5e0e87",
   300 => x"1e0e5d5c",
   301 => x"f3c24c71",
   302 => x"c149bffe",
   303 => x"c14da1cd",
   304 => x"7e6981d1",
   305 => x"cf029c74",
   306 => x"4ba5c487",
   307 => x"f3c27b74",
   308 => x"f349bffe",
   309 => x"7b6e87c8",
   310 => x"c4059c74",
   311 => x"c24bc087",
   312 => x"734bc187",
   313 => x"87c9f349",
   314 => x"c70266d4",
   315 => x"87da4987",
   316 => x"87c24a70",
   317 => x"d4c24ac0",
   318 => x"f2265aca",
   319 => x"000087d8",
   320 => x"00000000",
   321 => x"00000000",
   322 => x"711e0000",
   323 => x"bfc8ff4a",
   324 => x"48a17249",
   325 => x"ff1e4f26",
   326 => x"fe89bfc8",
   327 => x"c0c0c0c0",
   328 => x"c401a9c0",
   329 => x"c24ac087",
   330 => x"724ac187",
   331 => x"0e4f2648",
   332 => x"5d5c5b5e",
   333 => x"ff4b710e",
   334 => x"66d04cd4",
   335 => x"d678c048",
   336 => x"ecdbff49",
   337 => x"7cffc387",
   338 => x"ffc3496c",
   339 => x"494d7199",
   340 => x"c199f0c3",
   341 => x"cb05a9e0",
   342 => x"7cffc387",
   343 => x"98c3486c",
   344 => x"780866d0",
   345 => x"6c7cffc3",
   346 => x"31c8494a",
   347 => x"6c7cffc3",
   348 => x"72b2714a",
   349 => x"c331c849",
   350 => x"4a6c7cff",
   351 => x"4972b271",
   352 => x"ffc331c8",
   353 => x"714a6c7c",
   354 => x"48d0ffb2",
   355 => x"7378e0c0",
   356 => x"87c2029b",
   357 => x"48757b72",
   358 => x"4c264d26",
   359 => x"4f264b26",
   360 => x"0e4f261e",
   361 => x"0e5c5b5e",
   362 => x"1e7686f8",
   363 => x"fd49a6c8",
   364 => x"86c487fd",
   365 => x"486e4b70",
   366 => x"c303a8c2",
   367 => x"4a7387ca",
   368 => x"c19af0c3",
   369 => x"c702aad0",
   370 => x"aae0c187",
   371 => x"87f8c205",
   372 => x"99c84973",
   373 => x"ff87c302",
   374 => x"4c7387c6",
   375 => x"acc29cc3",
   376 => x"87cfc105",
   377 => x"c94966c4",
   378 => x"c41e7131",
   379 => x"f8c04a66",
   380 => x"c6f4c292",
   381 => x"fe817249",
   382 => x"c487e3d2",
   383 => x"c01e4966",
   384 => x"d9ff49e3",
   385 => x"49d887d0",
   386 => x"87e5d8ff",
   387 => x"c21ec0c8",
   388 => x"fd49f6e2",
   389 => x"ff87c4eb",
   390 => x"e0c048d0",
   391 => x"f6e2c278",
   392 => x"4a66d01e",
   393 => x"c292f8c0",
   394 => x"7249c6f4",
   395 => x"eccdfe81",
   396 => x"c186d087",
   397 => x"cfc105ac",
   398 => x"4966c487",
   399 => x"1e7131c9",
   400 => x"c04a66c4",
   401 => x"f4c292f8",
   402 => x"817249c6",
   403 => x"87ced1fe",
   404 => x"1ef6e2c2",
   405 => x"c04a66c8",
   406 => x"f4c292f8",
   407 => x"817249c6",
   408 => x"87f6cbfe",
   409 => x"1e4966c8",
   410 => x"ff49e3c0",
   411 => x"d787e7d7",
   412 => x"fcd6ff49",
   413 => x"1ec0c887",
   414 => x"49f6e2c2",
   415 => x"87c5e9fd",
   416 => x"d0ff86d0",
   417 => x"78e0c048",
   418 => x"cdfc8ef8",
   419 => x"5b5e0e87",
   420 => x"1e0e5d5c",
   421 => x"d4ff4d71",
   422 => x"7e66d44c",
   423 => x"a8b7c348",
   424 => x"c087c506",
   425 => x"87e3c148",
   426 => x"e1fe4975",
   427 => x"1e7587d7",
   428 => x"c04b66c4",
   429 => x"f4c293f8",
   430 => x"497383c6",
   431 => x"87cdc6fe",
   432 => x"4b6b83c8",
   433 => x"c848d0ff",
   434 => x"7cdd78e1",
   435 => x"ffc34973",
   436 => x"737c7199",
   437 => x"29b7c849",
   438 => x"7199ffc3",
   439 => x"d049737c",
   440 => x"ffc329b7",
   441 => x"737c7199",
   442 => x"29b7d849",
   443 => x"7cc07c71",
   444 => x"7c7c7c7c",
   445 => x"7c7c7c7c",
   446 => x"c07c7c7c",
   447 => x"66c478e0",
   448 => x"ff49dc1e",
   449 => x"c887cfd5",
   450 => x"26487386",
   451 => x"0e87c9fa",
   452 => x"5d5c5b5e",
   453 => x"7e711e0e",
   454 => x"6e4bd4ff",
   455 => x"f6f5c21e",
   456 => x"e8c4fe49",
   457 => x"7086c487",
   458 => x"c3029d4d",
   459 => x"f5c287c3",
   460 => x"6e4cbffe",
   461 => x"ccdffe49",
   462 => x"48d0ff87",
   463 => x"c178c5c8",
   464 => x"4ac07bd6",
   465 => x"82c17b15",
   466 => x"aab7e0c0",
   467 => x"ff87f504",
   468 => x"78c448d0",
   469 => x"c178c5c8",
   470 => x"7bc17bd3",
   471 => x"9c7478c4",
   472 => x"87fcc102",
   473 => x"7ef6e2c2",
   474 => x"8c4dc0c8",
   475 => x"03acb7c0",
   476 => x"c0c887c6",
   477 => x"4cc04da4",
   478 => x"97e7efc2",
   479 => x"99d049bf",
   480 => x"c087d202",
   481 => x"f6f5c21e",
   482 => x"cdc7fe49",
   483 => x"7086c487",
   484 => x"efc04a49",
   485 => x"f6e2c287",
   486 => x"f6f5c21e",
   487 => x"f9c6fe49",
   488 => x"7086c487",
   489 => x"d0ff4a49",
   490 => x"78c5c848",
   491 => x"6e7bd4c1",
   492 => x"6e7bbf97",
   493 => x"7080c148",
   494 => x"058dc17e",
   495 => x"ff87f0ff",
   496 => x"78c448d0",
   497 => x"c5059a72",
   498 => x"c048c087",
   499 => x"1ec187e5",
   500 => x"49f6f5c2",
   501 => x"87e1c4fe",
   502 => x"9c7486c4",
   503 => x"87c4fe05",
   504 => x"c848d0ff",
   505 => x"d3c178c5",
   506 => x"c47bc07b",
   507 => x"c248c178",
   508 => x"2648c087",
   509 => x"4c264d26",
   510 => x"4f264b26",
   511 => x"5c5b5e0e",
   512 => x"cc4b710e",
   513 => x"87d80266",
   514 => x"8cf0c04c",
   515 => x"7487d802",
   516 => x"028ac14a",
   517 => x"028a87d1",
   518 => x"028a87cd",
   519 => x"87d787c9",
   520 => x"eafb4973",
   521 => x"7487d087",
   522 => x"f949c01e",
   523 => x"1e7487df",
   524 => x"d8f94973",
   525 => x"fe86c887",
   526 => x"1e0087fc",
   527 => x"bfc9e2c2",
   528 => x"c2b9c149",
   529 => x"ff59cde2",
   530 => x"ffc348d4",
   531 => x"48d0ff78",
   532 => x"ff78e1c8",
   533 => x"78c148d4",
   534 => x"787131c4",
   535 => x"c048d0ff",
   536 => x"4f2678e0",
   537 => x"fde1c21e",
   538 => x"f6f5c21e",
   539 => x"dcfffd49",
   540 => x"7086c487",
   541 => x"87c30298",
   542 => x"2687c0ff",
   543 => x"4b35314f",
   544 => x"20205a48",
   545 => x"47464320",
   546 => x"00000000",
   547 => x"00000000",
  others => ( x"00000000")
);

-- Xilinx Vivado attributes
attribute ram_style: string;
attribute ram_style of ram: signal is "block";

signal q_local : std_logic_vector((NB_COL * COL_WIDTH)-1 downto 0);

signal wea : std_logic_vector(NB_COL - 1 downto 0);

begin

	output:
	for i in 0 to NB_COL - 1 generate
		q((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= q_local((i+1) * COL_WIDTH - 1 downto i * COL_WIDTH);
	end generate;
    
    -- Generate write enable signals
    -- The Block ram generator doesn't like it when the compare is done in the if statement it self.
    wea <= bytesel when we = '1' else (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            q_local <= ram(to_integer(unsigned(addr)));
            for i in 0 to NB_COL - 1 loop
                if (wea(NB_COL-i-1) = '1') then
                    ram(to_integer(unsigned(addr)))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= d((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                end if;
            end loop;
        end if;
    end process;

end arch;
