@rem ==========================================
@rem ����������������Ƽ����޹�˾
@rem 2017-04-18
@rem http://www.yunyangtao.com/web/index.html
@rem ==========================================

@echo off
setlocal

@rem ==========================================
@rem �����̳�ƽ̨���ֲ�ʽ�ܹ���maven build
@rem ��ػ����У�dev��test��sta��pre��pro
@rem  pro(production����������) , pre(preview��Ԥ��������) , test�����Ի����� , dev(develop����������) , sta (stable���ȶ�����)
@rem ==========================================

@rem call mvn clean install
@rem call mvn -f msyt-all-pom.xml clean install -Dmaven.test.skip=true -P dev
@rem call mvn -f msyt-all-pom.xml clean install -Dmaven.test.skip=true
@rem call mvn -f msyt-all-pom.xml clean install -Dmaven.test.skip=true -P dev
call mvn -f msyt-all-pom.xml clean install -Dmaven.test.skip=true -P sta
:end
endlocal
pause