@rem ==========================================
@rem ����������������Ƽ����޹�˾
@rem 2017-04-18
@rem http://www.yunyangtao.com/web/index.html
@rem ==========================================

@echo off
setlocal

@rem ==========================================
@rem �����̳�ƽ̨���ֲ�ʽ�ܹ���maven deploy
@rem ==========================================

@rem call mvn clean install
@rem call mvn -f msyt-all-pom.xml clean deploy -Dmaven.test.skip=true -p dev
call mvn -f msyt-all-pom.xml clean deploy -Dmaven.test.skip=true
:end
endlocal
pause