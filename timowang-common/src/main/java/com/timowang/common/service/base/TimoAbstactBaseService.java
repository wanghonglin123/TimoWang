package com.timowang.common.service.base;
/**
 * @Title: TimoAbstactBaseService
 * @Package: com.timowang.common.service.base
 * @Description:
 * @Author: WangHongLin
 * @Date: 2018-01-07 上午 2:16
 * @Version: V2.0.0
 */

import com.timowang.common.adapter.pojo.TimoBasePoAdapter;
import com.timowang.common.beans.TimoBeans;
import com.timowang.common.exception.TimoBaseException;
import com.timowang.common.exception.TimoException;
import com.timowang.common.utils.TimoReflectionUtils;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * @ClassName: TimoAbstactBaseService
 * @Description: 顶级父接口抽象，用于扩展和抽取相同代码
 * @Author: WangHongLin
 * @Date: 2018-01-07 上午 2:16
 */
public abstract class TimoAbstactBaseService<T extends TimoBasePoAdapter, E extends TimoBaseException> extends TimoBeans{

    private Class<T> targetClazz;

    public Class<T> getTargetClass() throws TimoException{
        if (this.targetClazz != null) {
            return this.targetClazz;
        }
        return this.targetClazz = (Class<T>) TimoReflectionUtils.getSuperclassParameterizedType(getClass(), 0);
    }

}
