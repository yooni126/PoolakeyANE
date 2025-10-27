package com.doitflash.math 
{
	/**
	 * ...
	 * @author majid
	 */
	public class Math2 
	{
		
		public function Math2():void
		{
			
		}
		
		//-----------------factorial
		
		public static function factorial(val:Number):Number
		{
			var answer:Number = 1;
			var integer:int = val;
			
			if (val == 0)
			{
				answer = 1;
			}
			else if (integer == val && val > 0)
			{
				var i:int = 0;
				for (i = integer; i > 0; i--) 
				{
					answer *= i;
				}
			}
			else if (integer == val && val < 0)
			{
				answer *= NaN;
			}
			else
			{
				answer = calculateMethod(val);
			}
			
			function calculateMethod(n:Number):Number
			{
				if (n > 0)
				{
					for (i = 0; i < integer; i++) 
					{
						answer *= (n - i);
					}
					
					n = n - integer;
				}
				else
				{
					integer = Math.ceil(n);
					for (i = 0; i > integer; i--) 
					{
						answer /= (n - i + 1);
					}
					
					n = n - integer;
				}
				
				var k:Number = 0;
				var multiplyToAnswer:Number = 1;
				
				for (k = 1; k < 1000000; k++) 
				{
					//answer *= Math.pow(((k + 1) / k), n) * (k / (n + k));
					
					multiplyToAnswer *= Math.pow(((k + 500) / k), n) * (k / (n + k)) * ((k + 1) / (n + k + 1)) * ((k + 2) / (n + k + 2)) * ((k + 3) / (n + k + 3)) * ((k + 4) / (n + k + 4)) * ((k + 5) / (n + k + 5)) * ((k + 6) / (n + k + 6)) * ((k + 7) / (n + k + 7)) * ((k + 8) / (n + k + 8)) * ((k + 9) / (n + k + 9)) * ((k + 10) / (n + k + 10)) * ((k + 11) / (n + k + 11)) * ((k + 12) / (n + k + 12)) * ((k + 13) / (n + k + 13)) * ((k + 14) / (n + k + 14)) * ((k + 15) / (n + k + 15)) * ((k + 16) / (n + k + 16)) * ((k + 17) / (n + k + 17)) * ((k + 18) / (n + k + 18)) * ((k + 19) / (n + k + 19)) * ((k + 20) / (n + k + 20)) * ((k + 21) / (n + k + 21)) * ((k + 22) / (n + k + 22)) * ((k + 23) / (n + k + 23)) * ((k + 24) / (n + k + 24)) * ((k + 25) / (n + k + 25)) * ((k + 26) / (n + k + 26)) * ((k + 27) / (n + k + 27)) * ((k + 28) / (n + k + 28)) * ((k + 29) / (n + k + 29)) * ((k + 30) / (n + k + 30)) * ((k + 31) / (n + k + 31)) * ((k + 32) / (n + k + 32)) * ((k + 33) / (n + k + 33)) * ((k + 34) / (n + k + 34)) * ((k + 35) / (n + k + 35)) * ((k + 36) / (n + k + 36)) * ((k + 37) / (n + k + 37)) * ((k + 38) / (n + k + 38)) * ((k + 39) / (n + k + 39)) * ((k + 40) / (n + k + 40)) * ((k + 41) / (n + k + 41)) * ((k + 42) / (n + k + 42)) * ((k + 43) / (n + k + 43)) * ((k + 44) / (n + k + 44)) * ((k + 45) / (n + k + 45)) * ((k + 46) / (n + k + 46)) * ((k + 47) / (n + k + 47)) * ((k + 48) / (n + k + 48)) * ((k + 49) / (n + k + 49)) * ((k + 50) / (n + k + 50)) * ((k + 51) / (n + k + 51)) * ((k + 52) / (n + k + 52)) * ((k + 53) / (n + k + 53)) * ((k + 54) / (n + k + 54)) * ((k + 55) / (n + k + 55)) * ((k + 56) / (n + k + 56)) * ((k + 57) / (n + k + 57)) * ((k + 58) / (n + k + 58)) * ((k + 59) / (n + k + 59)) * ((k + 60) / (n + k + 60)) * ((k + 61) / (n + k + 61)) * ((k + 62) / (n + k + 62)) * ((k + 63) / (n + k + 63)) * ((k + 64) / (n + k + 64)) * ((k + 65) / (n + k + 65)) * ((k + 66) / (n + k + 66)) * ((k + 67) / (n + k + 67)) * ((k + 68) / (n + k + 68)) * ((k + 69) / (n + k + 69)) * ((k + 70) / (n + k + 70)) * ((k + 71) / (n + k + 71)) * ((k + 72) / (n + k + 72)) * ((k + 73) / (n + k + 73)) * ((k + 74) / (n + k + 74)) * ((k + 75) / (n + k + 75)) * ((k + 76) / (n + k + 76)) * ((k + 77) / (n + k + 77)) * ((k + 78) / (n + k + 78)) * ((k + 79) / (n + k + 79)) * ((k + 80) / (n + k + 80)) * ((k + 81) / (n + k + 81)) * ((k + 82) / (n + k + 82)) * ((k + 83) / (n + k + 83)) * ((k + 84) / (n + k + 84)) * ((k + 85) / (n + k + 85)) * ((k + 86) / (n + k + 86)) * ((k + 87) / (n + k + 87)) * ((k + 88) / (n + k + 88)) * ((k + 89) / (n + k + 89)) * ((k + 90) / (n + k + 90)) * ((k + 91) / (n + k + 91)) * ((k + 92) / (n + k + 92)) * ((k + 93) / (n + k + 93)) * ((k + 94) / (n + k + 94)) * ((k + 95) / (n + k + 95)) * ((k + 96) / (n + k + 96)) * ((k + 97) / (n + k + 97)) * ((k + 98) / (n + k + 98)) * ((k + 99) / (n + k + 99)) * ((k + 100) / (n + k + 100)) * ((k + 101) / (n + k + 101)) * ((k + 102) / (n + k + 102)) * ((k + 103) / (n + k + 103)) * ((k + 104) / (n + k + 104)) * ((k + 105) / (n + k + 105)) * ((k + 106) / (n + k + 106)) * ((k + 107) / (n + k + 107)) * ((k + 108) / (n + k + 108)) * ((k + 109) / (n + k + 109)) * ((k + 110) / (n + k + 110)) * ((k + 111) / (n + k + 111)) * ((k + 112) / (n + k + 112)) * ((k + 113) / (n + k + 113)) * ((k + 114) / (n + k + 114)) * ((k + 115) / (n + k + 115)) * ((k + 116) / (n + k + 116)) * ((k + 117) / (n + k + 117)) * ((k + 118) / (n + k + 118)) * ((k + 119) / (n + k + 119)) * ((k + 120) / (n + k + 120)) * ((k + 121) / (n + k + 121)) * ((k + 122) / (n + k + 122)) * ((k + 123) / (n + k + 123)) * ((k + 124) / (n + k + 124)) * ((k + 125) / (n + k + 125)) * ((k + 126) / (n + k + 126)) * ((k + 127) / (n + k + 127)) * ((k + 128) / (n + k + 128)) * ((k + 129) / (n + k + 129)) * ((k + 130) / (n + k + 130)) * ((k + 131) / (n + k + 131)) * ((k + 132) / (n + k + 132)) * ((k + 133) / (n + k + 133)) * ((k + 134) / (n + k + 134)) * ((k + 135) / (n + k + 135)) * ((k + 136) / (n + k + 136)) * ((k + 137) / (n + k + 137)) * ((k + 138) / (n + k + 138)) * ((k + 139) / (n + k + 139)) * ((k + 140) / (n + k + 140)) * ((k + 141) / (n + k + 141)) * ((k + 142) / (n + k + 142)) * ((k + 143) / (n + k + 143)) * ((k + 144) / (n + k + 144)) * ((k + 145) / (n + k + 145)) * ((k + 146) / (n + k + 146)) * ((k + 147) / (n + k + 147)) * ((k + 148) / (n + k + 148)) * ((k + 149) / (n + k + 149)) * ((k + 150) / (n + k + 150)) * ((k + 151) / (n + k + 151)) * ((k + 152) / (n + k + 152)) * ((k + 153) / (n + k + 153)) * ((k + 154) / (n + k + 154)) * ((k + 155) / (n + k + 155)) * ((k + 156) / (n + k + 156)) * ((k + 157) / (n + k + 157)) * ((k + 158) / (n + k + 158)) * ((k + 159) / (n + k + 159)) * ((k + 160) / (n + k + 160)) * ((k + 161) / (n + k + 161)) * ((k + 162) / (n + k + 162)) * ((k + 163) / (n + k + 163)) * ((k + 164) / (n + k + 164)) * ((k + 165) / (n + k + 165)) * ((k + 166) / (n + k + 166)) * ((k + 167) / (n + k + 167)) * ((k + 168) / (n + k + 168)) * ((k + 169) / (n + k + 169)) * ((k + 170) / (n + k + 170)) * ((k + 171) / (n + k + 171)) * ((k + 172) / (n + k + 172)) * ((k + 173) / (n + k + 173)) * ((k + 174) / (n + k + 174)) * ((k + 175) / (n + k + 175)) * ((k + 176) / (n + k + 176)) * ((k + 177) / (n + k + 177)) * ((k + 178) / (n + k + 178)) * ((k + 179) / (n + k + 179)) * ((k + 180) / (n + k + 180)) * ((k + 181) / (n + k + 181)) * ((k + 182) / (n + k + 182)) * ((k + 183) / (n + k + 183)) * ((k + 184) / (n + k + 184)) * ((k + 185) / (n + k + 185)) * ((k + 186) / (n + k + 186)) * ((k + 187) / (n + k + 187)) * ((k + 188) / (n + k + 188)) * ((k + 189) / (n + k + 189)) * ((k + 190) / (n + k + 190)) * ((k + 191) / (n + k + 191)) * ((k + 192) / (n + k + 192)) * ((k + 193) / (n + k + 193)) * ((k + 194) / (n + k + 194)) * ((k + 195) / (n + k + 195)) * ((k + 196) / (n + k + 196)) * ((k + 197) / (n + k + 197)) * ((k + 198) / (n + k + 198)) * ((k + 199) / (n + k + 199)) * ((k + 200) / (n + k + 200)) * ((k + 201) / (n + k + 201)) * ((k + 202) / (n + k + 202)) * ((k + 203) / (n + k + 203)) * ((k + 204) / (n + k + 204)) * ((k + 205) / (n + k + 205)) * ((k + 206) / (n + k + 206)) * ((k + 207) / (n + k + 207)) * ((k + 208) / (n + k + 208)) * ((k + 209) / (n + k + 209)) * ((k + 210) / (n + k + 210)) * ((k + 211) / (n + k + 211)) * ((k + 212) / (n + k + 212)) * ((k + 213) / (n + k + 213)) * ((k + 214) / (n + k + 214)) * ((k + 215) / (n + k + 215)) * ((k + 216) / (n + k + 216)) * ((k + 217) / (n + k + 217)) * ((k + 218) / (n + k + 218)) * ((k + 219) / (n + k + 219)) * ((k + 220) / (n + k + 220)) * ((k + 221) / (n + k + 221)) * ((k + 222) / (n + k + 222)) * ((k + 223) / (n + k + 223)) * ((k + 224) / (n + k + 224)) * ((k + 225) / (n + k + 225)) * ((k + 226) / (n + k + 226)) * ((k + 227) / (n + k + 227)) * ((k + 228) / (n + k + 228)) * ((k + 229) / (n + k + 229)) * ((k + 230) / (n + k + 230)) * ((k + 231) / (n + k + 231)) * ((k + 232) / (n + k + 232)) * ((k + 233) / (n + k + 233)) * ((k + 234) / (n + k + 234)) * ((k + 235) / (n + k + 235)) * ((k + 236) / (n + k + 236)) * ((k + 237) / (n + k + 237)) * ((k + 238) / (n + k + 238)) * ((k + 239) / (n + k + 239)) * ((k + 240) / (n + k + 240)) * ((k + 241) / (n + k + 241)) * ((k + 242) / (n + k + 242)) * ((k + 243) / (n + k + 243)) * ((k + 244) / (n + k + 244)) * ((k + 245) / (n + k + 245)) * ((k + 246) / (n + k + 246)) * ((k + 247) / (n + k + 247)) * ((k + 248) / (n + k + 248)) * ((k + 249) / (n + k + 249)) * ((k + 250) / (n + k + 250)) * ((k + 251) / (n + k + 251)) * ((k + 252) / (n + k + 252)) * ((k + 253) / (n + k + 253)) * ((k + 254) / (n + k + 254)) * ((k + 255) / (n + k + 255)) * ((k + 256) / (n + k + 256)) * ((k + 257) / (n + k + 257)) * ((k + 258) / (n + k + 258)) * ((k + 259) / (n + k + 259)) * ((k + 260) / (n + k + 260)) * ((k + 261) / (n + k + 261)) * ((k + 262) / (n + k + 262)) * ((k + 263) / (n + k + 263)) * ((k + 264) / (n + k + 264)) * ((k + 265) / (n + k + 265)) * ((k + 266) / (n + k + 266)) * ((k + 267) / (n + k + 267)) * ((k + 268) / (n + k + 268)) * ((k + 269) / (n + k + 269)) * ((k + 270) / (n + k + 270)) * ((k + 271) / (n + k + 271)) * ((k + 272) / (n + k + 272)) * ((k + 273) / (n + k + 273)) * ((k + 274) / (n + k + 274)) * ((k + 275) / (n + k + 275)) * ((k + 276) / (n + k + 276)) * ((k + 277) / (n + k + 277)) * ((k + 278) / (n + k + 278)) * ((k + 279) / (n + k + 279)) * ((k + 280) / (n + k + 280)) * ((k + 281) / (n + k + 281)) * ((k + 282) / (n + k + 282)) * ((k + 283) / (n + k + 283)) * ((k + 284) / (n + k + 284)) * ((k + 285) / (n + k + 285)) * ((k + 286) / (n + k + 286)) * ((k + 287) / (n + k + 287)) * ((k + 288) / (n + k + 288)) * ((k + 289) / (n + k + 289)) * ((k + 290) / (n + k + 290)) * ((k + 291) / (n + k + 291)) * ((k + 292) / (n + k + 292)) * ((k + 293) / (n + k + 293)) * ((k + 294) / (n + k + 294)) * ((k + 295) / (n + k + 295)) * ((k + 296) / (n + k + 296)) * ((k + 297) / (n + k + 297)) * ((k + 298) / (n + k + 298)) * ((k + 299) / (n + k + 299)) * ((k + 300) / (n + k + 300)) * ((k + 301) / (n + k + 301)) * ((k + 302) / (n + k + 302)) * ((k + 303) / (n + k + 303)) * ((k + 304) / (n + k + 304)) * ((k + 305) / (n + k + 305)) * ((k + 306) / (n + k + 306)) * ((k + 307) / (n + k + 307)) * ((k + 308) / (n + k + 308)) * ((k + 309) / (n + k + 309)) * ((k + 310) / (n + k + 310)) * ((k + 311) / (n + k + 311)) * ((k + 312) / (n + k + 312)) * ((k + 313) / (n + k + 313)) * ((k + 314) / (n + k + 314)) * ((k + 315) / (n + k + 315)) * ((k + 316) / (n + k + 316)) * ((k + 317) / (n + k + 317)) * ((k + 318) / (n + k + 318)) * ((k + 319) / (n + k + 319)) * ((k + 320) / (n + k + 320)) * ((k + 321) / (n + k + 321)) * ((k + 322) / (n + k + 322)) * ((k + 323) / (n + k + 323)) * ((k + 324) / (n + k + 324)) * ((k + 325) / (n + k + 325)) * ((k + 326) / (n + k + 326)) * ((k + 327) / (n + k + 327)) * ((k + 328) / (n + k + 328)) * ((k + 329) / (n + k + 329)) * ((k + 330) / (n + k + 330)) * ((k + 331) / (n + k + 331)) * ((k + 332) / (n + k + 332)) * ((k + 333) / (n + k + 333)) * ((k + 334) / (n + k + 334)) * ((k + 335) / (n + k + 335)) * ((k + 336) / (n + k + 336)) * ((k + 337) / (n + k + 337)) * ((k + 338) / (n + k + 338)) * ((k + 339) / (n + k + 339)) * ((k + 340) / (n + k + 340)) * ((k + 341) / (n + k + 341)) * ((k + 342) / (n + k + 342)) * ((k + 343) / (n + k + 343)) * ((k + 344) / (n + k + 344)) * ((k + 345) / (n + k + 345)) * ((k + 346) / (n + k + 346)) * ((k + 347) / (n + k + 347)) * ((k + 348) / (n + k + 348)) * ((k + 349) / (n + k + 349)) * ((k + 350) / (n + k + 350)) * ((k + 351) / (n + k + 351)) * ((k + 352) / (n + k + 352)) * ((k + 353) / (n + k + 353)) * ((k + 354) / (n + k + 354)) * ((k + 355) / (n + k + 355)) * ((k + 356) / (n + k + 356)) * ((k + 357) / (n + k + 357)) * ((k + 358) / (n + k + 358)) * ((k + 359) / (n + k + 359)) * ((k + 360) / (n + k + 360)) * ((k + 361) / (n + k + 361)) * ((k + 362) / (n + k + 362)) * ((k + 363) / (n + k + 363)) * ((k + 364) / (n + k + 364)) * ((k + 365) / (n + k + 365)) * ((k + 366) / (n + k + 366)) * ((k + 367) / (n + k + 367)) * ((k + 368) / (n + k + 368)) * ((k + 369) / (n + k + 369)) * ((k + 370) / (n + k + 370)) * ((k + 371) / (n + k + 371)) * ((k + 372) / (n + k + 372)) * ((k + 373) / (n + k + 373)) * ((k + 374) / (n + k + 374)) * ((k + 375) / (n + k + 375)) * ((k + 376) / (n + k + 376)) * ((k + 377) / (n + k + 377)) * ((k + 378) / (n + k + 378)) * ((k + 379) / (n + k + 379)) * ((k + 380) / (n + k + 380)) * ((k + 381) / (n + k + 381)) * ((k + 382) / (n + k + 382)) * ((k + 383) / (n + k + 383)) * ((k + 384) / (n + k + 384)) * ((k + 385) / (n + k + 385)) * ((k + 386) / (n + k + 386)) * ((k + 387) / (n + k + 387)) * ((k + 388) / (n + k + 388)) * ((k + 389) / (n + k + 389)) * ((k + 390) / (n + k + 390)) * ((k + 391) / (n + k + 391)) * ((k + 392) / (n + k + 392)) * ((k + 393) / (n + k + 393)) * ((k + 394) / (n + k + 394)) * ((k + 395) / (n + k + 395)) * ((k + 396) / (n + k + 396)) * ((k + 397) / (n + k + 397)) * ((k + 398) / (n + k + 398)) * ((k + 399) / (n + k + 399)) * ((k + 400) / (n + k + 400)) * ((k + 401) / (n + k + 401)) * ((k + 402) / (n + k + 402)) * ((k + 403) / (n + k + 403)) * ((k + 404) / (n + k + 404)) * ((k + 405) / (n + k + 405)) * ((k + 406) / (n + k + 406)) * ((k + 407) / (n + k + 407)) * ((k + 408) / (n + k + 408)) * ((k + 409) / (n + k + 409)) * ((k + 410) / (n + k + 410)) * ((k + 411) / (n + k + 411)) * ((k + 412) / (n + k + 412)) * ((k + 413) / (n + k + 413)) * ((k + 414) / (n + k + 414)) * ((k + 415) / (n + k + 415)) * ((k + 416) / (n + k + 416)) * ((k + 417) / (n + k + 417)) * ((k + 418) / (n + k + 418)) * ((k + 419) / (n + k + 419)) * ((k + 420) / (n + k + 420)) * ((k + 421) / (n + k + 421)) * ((k + 422) / (n + k + 422)) * ((k + 423) / (n + k + 423)) * ((k + 424) / (n + k + 424)) * ((k + 425) / (n + k + 425)) * ((k + 426) / (n + k + 426)) * ((k + 427) / (n + k + 427)) * ((k + 428) / (n + k + 428)) * ((k + 429) / (n + k + 429)) * ((k + 430) / (n + k + 430)) * ((k + 431) / (n + k + 431)) * ((k + 432) / (n + k + 432)) * ((k + 433) / (n + k + 433)) * ((k + 434) / (n + k + 434)) * ((k + 435) / (n + k + 435)) * ((k + 436) / (n + k + 436)) * ((k + 437) / (n + k + 437)) * ((k + 438) / (n + k + 438)) * ((k + 439) / (n + k + 439)) * ((k + 440) / (n + k + 440)) * ((k + 441) / (n + k + 441)) * ((k + 442) / (n + k + 442)) * ((k + 443) / (n + k + 443)) * ((k + 444) / (n + k + 444)) * ((k + 445) / (n + k + 445)) * ((k + 446) / (n + k + 446)) * ((k + 447) / (n + k + 447)) * ((k + 448) / (n + k + 448)) * ((k + 449) / (n + k + 449)) * ((k + 450) / (n + k + 450)) * ((k + 451) / (n + k + 451)) * ((k + 452) / (n + k + 452)) * ((k + 453) / (n + k + 453)) * ((k + 454) / (n + k + 454)) * ((k + 455) / (n + k + 455)) * ((k + 456) / (n + k + 456)) * ((k + 457) / (n + k + 457)) * ((k + 458) / (n + k + 458)) * ((k + 459) / (n + k + 459)) * ((k + 460) / (n + k + 460)) * ((k + 461) / (n + k + 461)) * ((k + 462) / (n + k + 462)) * ((k + 463) / (n + k + 463)) * ((k + 464) / (n + k + 464)) * ((k + 465) / (n + k + 465)) * ((k + 466) / (n + k + 466)) * ((k + 467) / (n + k + 467)) * ((k + 468) / (n + k + 468)) * ((k + 469) / (n + k + 469)) * ((k + 470) / (n + k + 470)) * ((k + 471) / (n + k + 471)) * ((k + 472) / (n + k + 472)) * ((k + 473) / (n + k + 473)) * ((k + 474) / (n + k + 474)) * ((k + 475) / (n + k + 475)) * ((k + 476) / (n + k + 476)) * ((k + 477) / (n + k + 477)) * ((k + 478) / (n + k + 478)) * ((k + 479) / (n + k + 479)) * ((k + 480) / (n + k + 480)) * ((k + 481) / (n + k + 481)) * ((k + 482) / (n + k + 482)) * ((k + 483) / (n + k + 483)) * ((k + 484) / (n + k + 484)) * ((k + 485) / (n + k + 485)) * ((k + 486) / (n + k + 486)) * ((k + 487) / (n + k + 487)) * ((k + 488) / (n + k + 488)) * ((k + 489) / (n + k + 489)) * ((k + 490) / (n + k + 490)) * ((k + 491) / (n + k + 491)) * ((k + 492) / (n + k + 492)) * ((k + 493) / (n + k + 493)) * ((k + 494) / (n + k + 494)) * ((k + 495) / (n + k + 495)) * ((k + 496) / (n + k + 496)) * ((k + 497) / (n + k + 497)) * ((k + 498) / (n + k + 498)) * ((k + 499) / (n + k + 499));
					k += 500;
				}
				
				if (n <= 0.1 && n > 0)//3.2298819481637075128227345978319e-7
				{
					multiplyToAnswer -= (0.00000032298819481637075128227345978319 * (n / 0.1));
				}
				else if (n <= 0.2 && n > 0.1)//5.5410271048935904834481416962617e-7
				{
					multiplyToAnswer -= (0.00000055410271048935904834481416962617 - 0.00000032298819481637075128227345978319) / 0.1 * (n - 0.1) + 0.00000032298819481637075128227345978319;
				}
				else if (n <= 0.3 && n > 0.2)//7.1076986991150624504522852468635e-7
				{
					multiplyToAnswer -= (0.00000071076986991150624504522852468635 - 0.00000055410271048935904834481416962617) / 0.1 * (n - 0.2) + 0.00000055410271048935904834481416962617;
				}
				else if (n <= 0.4 && n > 0.3)//0.00000080299783401077637839123692823872
				{
					multiplyToAnswer -= (0.00000080299783401077637839123692823872 - 0.00000071076986991150624504522852468635) / 0.1 * (n - 0.3) + 0.00000071076986991150624504522852468635;
				}
				else if (n <= 0.5 && n > 0.4)//0.00000083543102488635091625832942755736
				{
					multiplyToAnswer -= (0.00000083543102488635091625832942755736 - 0.00000080299783401077637839123692823872) / 0.1 * (n - 0.4) + 0.00000080299783401077637839123692823872;
				}
				else if (n <= 0.6 && n > 0.5)//0.00000080856353593856339996700719473459
				{
					multiplyToAnswer -= (0.00000080856353593856339996700719473459 - 0.00000083543102488635091625832942755736) / 0.1 * (n - 0.5) + 0.00000083543102488635091625832942755736;
				}
				else if (n <= 0.7 && n > 0.6)//0.00000071940313815002318017459303269028
				{
					multiplyToAnswer -= (0.00000071940313815002318017459303269028 - 0.00000080856353593856339996700719473459) / 0.1 * (n - 0.6) + 0.00000080856353593856339996700719473459;
				}
				else if (n <= 0.8 && n > 0.7)//0.00000056176167580109094324938523358564
				{
					multiplyToAnswer -= (0.00000056176167580109094324938523358564 - 0.00000071940313815002318017459303269028) / 0.1 * (n - 0.7) + 0.00000071940313815002318017459303269028;
				}
				else if (n <= 0.9 && n > 0.8)//0.00000032625672228059242519787496764992
				{
					multiplyToAnswer -= (0.00000032625672228059242519787496764992 - 0.00000056176167580109094324938523358564) / 0.1 * (n - 0.8) + 0.00000056176167580109094324938523358564;
				}
				else if (n < 1 && n > 0.9)//0
				{
					multiplyToAnswer -= (0 - 0.00000032625672228059242519787496764992) / 0.1 * (n - 0.9) + 0.00000032625672228059242519787496764992;
				}
				
				
				answer *= multiplyToAnswer;
				
				return answer;
			}
			
			return answer;
		}
		
		//-----------------log10 log2 anyLog
		
		public static function log10(val:Number):Number
		{
			var answer:Number;
			answer = Math.log(val) / Math.LN10;
			var integer:int = answer;
			var integer1:int = answer + 1;
			
			if (Math.abs(answer - integer) < Math.pow(10, -13))
			{
				answer = integer;
			}
			else if (Math.abs(answer - integer1) < Math.pow(10, -13))
			{
				answer = integer1;
			}
			
			return answer;
		}
		
		public static function log2(val:Number):Number
		{
			var answer:Number;
			answer = Math.log(val) / Math.LN2;
			var integer:int = answer;
			var integer1:int = answer + 1;
			
			if (Math.abs(answer - integer) < Math.pow(10, -13))
			{
				answer = integer;
			}
			else if (Math.abs(answer - integer1) < Math.pow(10, -13))
			{
				answer = integer1;
			}
			
			return answer;
		}
		
		public static function anyLog(val:Number, base:Number):Number
		{
			var answer:Number;
			answer = Math.log(val) / Math.log(base);
			var integer:int = answer;
			var integer1:int = answer + 1;
			
			if (Math.abs(answer - integer) < Math.pow(10, -13))
			{
				answer = integer;
			}
			else if (Math.abs(answer - integer1) < Math.pow(10, -13))
			{
				answer = integer1;
			}
			
			return answer;
		}
		
		//-----------------sinh asinh
		
		public static function sinh(val:Number):Number
		{
			var answer:Number;
			answer = (Math.exp(val) - Math.exp(- val)) / 2;
			return answer;
		}
		
		public static function asinh(val:Number):Number
		{
			var answer:Number;
			answer = Math.log(val + Math.pow((val * val + 1), 0.5));
			return answer;
		}
		
		//-----------------cosh acosh
		
		public static function cosh(val:Number):Number
		{
			var answer:Number;
			answer = (Math.exp(val) + Math.exp(- val)) / 2;
			return answer;
		}
		
		public static function acosh(val:Number):Number
		{
			var answer:Number;
			answer = Math.log(val + Math.pow((val + 1), 0.5) * Math.pow((val - 1), 0.5));
			return answer;
		}
		
		//-----------------tanh atanh
		
		public static function tanh(val:Number):Number
		{
			var answer:Number;
			answer = (Math.exp(2 * val) - 1) / (Math.exp(2 * val) + 1);
			return answer;
		}
		
		public static function atanh(val:Number):Number
		{
			var answer:Number;
			answer = 0.5 * Math.log((1 + val) / (1 - val));
			return answer;
		}
		
		//-----------------cot acot coth acoth
		
		/**
		 * Computes and returns the value, in radians, of the angle whose cotangent is
		 * specified in the parameter val. The return value is between
		 * negative pi divided by 2 and positive pi divided by 2.
		 *
		 * @param	val: A number that represents the tangent of an angle.
		 * @return A number between negative pi divided by 2 and positive
		 * pi divided by 2.
		 */
		public static function cot(val:Number):Number
		{
			var cos:Number = Math.cos(val);
			var sin:Number = Math.sin(val);
			var answer:Number;
			
			if (val < 0)
			{
				var integer:int = val / ( -(2 * Math.PI)) + 1;
				val = val + integer * (2 * Math.PI);
				if (Math.abs(val) < Math.pow(10, -13))
				{
					val = 0;
				}
				else if (Math.abs(1 - (val / Math.PI)) < Math.pow(10, -13))
				{
					val = Math.PI;
				}
				else if (Math.abs((val / Math.PI) + 1) < Math.pow(10, -13))
				{
					val = Math.PI;
				}
			}
			else if (val > (2 * Math.PI))
			{
				var integer2:int = val / (2 * Math.PI);
				val = val - integer2 * (2 * Math.PI);
			}
			
			if (val == 0 || val == (Math.PI * 2))
			{
				answer = 16331239353195370;
			}
			else if (val == Math.PI || val == -Math.PI)
			{
				answer = cos * 16331239353195370;
			}
			else if (val == (Math.PI / 4) || val == (5 * Math.PI / 4))
			{
				answer = 1;
			}
			else if (val == (3 * Math.PI / 4) || val == (7 * Math.PI / 4))
			{
				answer = -1;
			}
			else if (val == (Math.PI / 2) || val == (3 * Math.PI / 2))
			{
				answer = 0;
			}
			else
			{
				answer = cos / sin;
			}
			
			if (Math.abs(answer) < Math.pow(10, -13))
			{
				answer = 0;
			}
			else if (Math.abs(1 - answer) < Math.pow(10, -13))
			{
				answer = 1;
			}
			else if (Math.abs(answer + 1) < Math.pow(10, -13))
			{
				answer = -1;
			}
			
			return answer;
		}
		
		public static function acot(val:Number):Number
		{
			var answer:Number;
			answer = (Math.PI / 2) - Math.atan(val);
			return answer;
		}
		
		/*public static function acot2(y:Number, x:Number):Number
		{
			var answer:Number;
			answer = (Math.PI / 2) - Math.atan2(y, x);
			return answer;
		}*/
		
		public static function coth(val:Number):Number
		{
			var answer:Number;
			answer = (Math.exp(2 * val) + 1) / (Math.exp(2 * val) - 1);
			return answer;
		}
		
		public static function acoth(val:Number):Number
		{
			var answer:Number;
			answer = 0.5 * Math.log((val + 1) / (val - 1));
			return answer;
		}
		
		//-----------------sec asec sech asech
		
		public static function sec(val:Number):Number
		{
			var answer:Number;
			answer = 1 / Math.cos(val);
			
			if (answer == 16331239353195370)
			{
				answer = Number.POSITIVE_INFINITY
			}
			else if (answer == -5443746451065123)
			{
				answer = Number.POSITIVE_INFINITY
			}
			
			return answer;
		}
		
		public static function asec(val:Number):Number
		{
			var answer:Number;
			answer = Math.acos(1 / val);
			return answer;
		}
		
		public static function sech(val:Number):Number
		{
			var answer:Number;
			answer = 2 / (Math.exp(val) + Math.exp(- val));
			return answer;
		}
		
		public static function asech(val:Number):Number
		{
			var answer:Number;
			answer = acosh((1 / val));
			return answer;
		}
		
		//-----------------csc acsc csch acsch
		
		public static function csc(val:Number):Number
		{
			var answer:Number;
			answer = 1 / Math.sin(val);
			
			if (answer >= 	2721873225532561)
			{
				answer = Number.POSITIVE_INFINITY
			}
			
			return answer;
		}
		
		public static function acsc(val:Number):Number
		{
			var answer:Number;
			answer = Math.asin(1 / val);
			return answer;
		}
		
		public static function csch(val:Number):Number
		{
			var answer:Number;
			answer = 2 / (Math.exp(val) - Math.exp(- val));
			return answer;
		}
		
		public static function acsch(val:Number):Number
		{
			var answer:Number;
			answer = asinh((1 / val));
			return answer;
		}
		
		//-----------------pow
		
		public static function pow(base:Number, pow:Number):Number
		{
			var answer:Number = anySqrt(base, (1 / pow));
			return answer;
		}
		
		//-----------------sqrt
		
		public static function anySqrt(base:Number, root:Number):Number
		{
			var answer:Number;
			var rootInt:int;
			
			if (root >= 1)
			{
				if (base >= 0)
				{
					answer = Math.pow(base, (1 / root));
				}
				else
				{
					rootInt = root;
					if (root == rootInt)
					{
						if (isEven(String(root)))
						{
							answer = NaN;
						}
						else
						{
							answer = - Math.pow(- base, (1 / root));
						}
					}
					else
					{
						answer = NaN;
					}
				}
			}
			else if (root >= 0)
			{
				answer = Math.pow(base, (1 / root));
			}
			else if (root >= -1)
			{
				answer = 1 / Math.pow(base, (1 / -root));
			}
			else
			{
				if (base >= 0)
				{
					answer = 1 / Math.pow(base, (1 / -root));
				}
				else
				{
					rootInt = root;
					if (root == rootInt)
					{
						if (isEven(String(root)))
						{
							answer = NaN;
						}
						else
						{
							answer = 1 / (- Math.pow(- base, (1 / -root)));
						}
					}
					else
					{
						answer = NaN;
					}
				}
			}
			
			return answer;
		}
		
		//-----------------isEven
		
		public static function isEven(val:String):Boolean
		{
			var answer:Boolean;
			var integer:int = int(val.slice( -1));
			switch (integer) 
			{
				case 0:
					answer = true;
				break;
				case 1:
					answer = false;
				break;
				case 2:
					answer = true;
				break;
				case 3:
					answer = false;
				break;
				case 4:
					answer = true;
				break;
				case 5:
					answer = false;
				break;
				case 6:
					answer = true;
				break;
				case 7:
					answer = false;
				break;
				case 8:
					answer = true;
				break;
				case 9:
					answer = false;
				break;
				default:
			}
			return answer;
		}
		
		//-----------------convert angle
		
		public static function degToRad($value:Number):Number
		{
			var answer:Number = $value * Math.PI / 180;
			return answer;
		}
		
		public static function radToDeg($value:Number):Number
		{
			var answer:Number = $value / Math.PI * 180;
			return answer;
		}
		
		public static function grdToDeg($value:Number):Number
		{
			var answer:Number = $value / 200 * 180;
			return answer;
		}
		
		public static function degToGrd($value:Number):Number
		{
			var answer:Number = $value / 180 * 200;
			return answer;
		}
		
		public static function radToGrd($value:Number):Number
		{
			var answer:Number = $value / Math.PI * 200;
			return answer;
		}
		
		public static function grdToRad($value:Number):Number
		{
			var answer:Number = $value * Math.PI / 200;
			return answer;
		}
		
	}

}