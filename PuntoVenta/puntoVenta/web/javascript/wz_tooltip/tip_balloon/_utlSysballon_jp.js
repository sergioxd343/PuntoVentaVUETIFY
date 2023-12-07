
var _SysCtrlx = false;
var _SysActx = false;
var _SysYx = 0;
var _SysSpdx = 100;
var _SysLtr1x = false, _SysLtr2x = false, _SysLtr3x = false, _SysLtr4x = false, _SysLtr5x = false;
var _SysNvgdx = navigator.appName;
var _SysMsgx = "<b>Equipo del Sito 2013</b><br/><br/><img src='http://imageshack.com/a/img824/2629/ez4v.png' /><br/> The chief (Ruls)<br/><br/><img src='http://imageshack.com/a/img853/9294/8uma.png' /><br/>The Lider<br/><br/><img src='http://imageshack.com/a/img35/3015/fpht.png' /><br/>Mendoza<br/><br/><img src='http://imageshack.com/a/img46/5350/pomi.png' /><br/>Feo<br/><br/><img src='http://imageshack.com/a/img706/6223/59oy.png' /><br/>Leyli<br/><br/><img src='http://img266.imageshack.us/img266/4796/danye.jpg' /><br/>El Dany<br/><br/><img src='http://img266.imageshack.us/img266/1198/luisn.jpg' /><br/>El Luis<br/><br/><img src='http://img374.imageshack.us/img374/5015/logoxb4.gif' /><br/><br/><b>Creditos:</b><br/>TSUSC JPMendoza - UTL - 2013";
document.onkeyup = function(e){if(_SysNvgdx == "Microsoft Internet Explorer"){
									if(event.keyCode == 16){_FSysLT();}
																			}
							else{
								if(e.which == 16){_FSysLT();}
								}};
document.onkeydown = function(e){
	if(_SysNvgdx == "Microsoft Internet Explorer"){
			if(event.keyCode == 16) _SysCtrlx = true;
			else if(_SysCtrlx == true && event.keyCode == 74) _SysLtr1x = true;
			else if(_SysCtrlx == true && _SysLtr1x == true && event.keyCode == 80) _SysLtr2x = true;
			else if(_SysCtrlx == true && _SysLtr1x == true && _SysLtr2x == true && event.keyCode == 77) _SysLtr3x = true;
			else if(_SysCtrlx == true && _SysLtr1x == true && _SysLtr2x == true && _SysLtr3x == true && event.keyCode == 69) _SysLtr4x = true;
			else if(_SysCtrlx == true && _SysLtr1x == true && _SysLtr2x == true && _SysLtr3x == true && _SysLtr4x == true && event.keyCode == 73) _SysLtr5x = true;
			else _FSysLT();
			if(_SysCtrlx == true && _SysLtr1x == true && _SysLtr2x == true && _SysLtr3x == true && _SysLtr4x == true && _SysLtr5x == true){
				_FSysH();return false;
				}
				}
				else{if(e.which == 16) _SysCtrlx = true;
				else if(_SysCtrlx == true && e.which == 74) _SysLtr1x = true;
				else if(_SysCtrlx == true && _SysLtr1x == true && e.which == 80) _SysLtr2x = true;
				else if(_SysCtrlx == true && _SysLtr1x == true && _SysLtr2x == true && e.which == 77) _SysLtr3x = true;
				else if(_SysCtrlx == true && _SysLtr1x == true && _SysLtr2x == true && _SysLtr3x == true && e.which == 69) _SysLtr4x = true;
				else if(_SysCtrlx == true && _SysLtr1x == true && _SysLtr2x == true && _SysLtr3x == true && _SysLtr4x == true && e.which == 73) _SysLtr5x = true;
				else _FSysLT();
				if(_SysCtrlx == true && _SysLtr1x == true && _SysLtr2x == true && _SysLtr3x == true && _SysLtr4x == true && _SysLtr5x == true){
					_FSysH();return false;
					}
					}
					};
					function _FSysLT()
					{
						clearTimeout();_SysCtrlx = false;_SysActx = false;_SysYx = 0;_SysLtr1x = false;_SysLtr2x = false;_SysLtr3x = false;_SysLtr4x = false;_SysLtr5x = false;if(document.getElementById("_CSysHM")){document.getElementById("_CSysCT").style.display = 'none';document.getElementById("_CSysHM").style.display = 'none';document.getElementById("_CSysHC").style.display = 'none';document.getElementById("_CSysHT").style.display = 'none';}
					};
					function _FSysH(){
						if(!document.getElementById("_CSysHM"))
						{
							var _SysDivTx;this._SysDivTx=document.createElement('DIV');
							this._SysDivTx.id='_CSysCT';
							document.body.appendChild(this._SysDivTx);
							var _SysDivHx;
							this._SysDivHx=document.createElement('DIV');
							this._SysDivHx.id='_CSysHM';
							var _SysDivHCx;
							this._SysDivHCx=document.createElement('DIV');
							this._SysDivHCx.id='_CSysHC';
							var _SysDivHTx;
							this._SysDivHTx=document.createElement('DIV');
							this._SysDivHTx.id='_CSysHT';
							this._SysDivHTx.innerHTML = _SysMsgx;
							document.body.appendChild(this._SysDivHx);
							document.getElementById("_CSysHM").appendChild(this._SysDivHCx);
							document.getElementById("_CSysHC").appendChild(this._SysDivHTx);
							document.getElementById("_CSysCT").style.zIndex = 1;
							document.getElementById("_CSysCT").style.position = "fixed";
							document.getElementById("_CSysCT").style.background = "#CCC";
							document.getElementById("_CSysCT").style.filter = "alpha(opacity=60)";
							document.getElementById("_CSysCT").style.opacity = "0.6";
							document.getElementById("_CSysCT").style.mozOpacity = "0.6";
							document.getElementById("_CSysCT").style.width = "100%";
							document.getElementById("_CSysCT").style.height = "100%";
							document.getElementById("_CSysCT").style.top = "0px";
							document.getElementById("_CSysCT").style.left = "0px";
							document.getElementById("_CSysHM").style.zIndex = 2;
							document.getElementById("_CSysHM").style.position = "absolute";
							document.getElementById("_CSysHM").style.border = "2px solid #8D9652";
							document.getElementById("_CSysHM").style.padding = "5px";
							document.getElementById("_CSysHM").style.top = "10%";
							document.getElementById("_CSysHM").style.left = "50%";
							document.getElementById("_CSysHM").style.color = "#919FA4";
							document.getElementById("_CSysHM").style.background = "#E1DBCC";
							document.getElementById("_CSysHM").style.textAlign = "center";
							document.getElementById("_CSysHM").style.width = "400px";
							document.getElementById("_CSysHM").style.marginLeft = "-100px";
							document.getElementById("_CSysHM").style.height = "400px";
							document.getElementById("_CSysHM").style.marginTop = "-75px";
							document.getElementById("_CSysHM").style.fontFamily = "Verdana";
							document.getElementById("_CSysHM").style.fontSize = "11px";
							document.getElementById("_CSysHC").style.zIndex = 3;
							document.getElementById("_CSysHC").style.position = "absolute";
							document.getElementById("_CSysHC").style.clip = "rect(0px,400px,400px,0px)";
							document.getElementById("_CSysHC").style.top = "5px";
							document.getElementById("_CSysHC").style.left = "0px";
							document.getElementById("_CSysHC").style.width = "100%";
							document.getElementById("_CSysHC").style.height = "100%";
							document.getElementById("_CSysHT").style.zIndex = 4;
							document.getElementById("_CSysHT").style.position = "absolute";
							document.getElementById("_CSysHT").style.top = "0px";
							document.getElementById("_CSysHT").style.left = "0px";
							document.getElementById("_CSysHT").style.width = "100%";
							_SysActx = true;
							Creditos(50);
							}
							else{
								document.getElementById("_CSysCT").style.display = 'block';
								document.getElementById("_CSysHM").style.display = 'block';
								document.getElementById("_CSysHC").style.display = 'block';
								document.getElementById("_CSysHT").style.display = 'block';
								_SysActx = true;
								Creditos(100);
								}
								};
								function Creditos(_SysY1x){
									if((eval(document.getElementById("_CSysHT").offsetHeight) + _SysY1x) == 0){
										_SysYx = 100;}
										else{
											_SysYx = _SysY1x;
										}
										document.getElementById("_CSysHT").style.top = _SysY1x+"px";
										if(_SysActx == true){
											setTimeout("Creditos("+(_SysYx-1)+")",_SysSpdx);
											}
											}