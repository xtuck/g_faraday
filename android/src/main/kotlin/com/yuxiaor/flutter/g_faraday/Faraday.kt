package com.yuxiaor.flutter.g_faraday

import android.app.Activity
import android.content.Intent
import com.yuxiaor.flutter.g_faraday.utils.ContextProvider
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.util.concurrent.atomic.AtomicInteger

/**
 * Author: Edward
 * Date: 2020-08-31
 * Description:
 */
object Faraday {

    private val nextCode = AtomicInteger()
    private val activityAwarePlugin = ActivityAwarePlugin()
    internal val faradayPlugin = GFaradayPlugin()

    @JvmStatic
    val engine by lazy { FlutterEngine(ContextProvider.context) }

    /**
     *  start engine
     */
    @JvmStatic
    fun startFlutterEngine(navigator: FaradayNavigator) {
        faradayPlugin.setNavigator(navigator)
        //注册插件
        registerPlugin(faradayPlugin)
        registerPlugin(activityAwarePlugin)
        //开始执行dart代码，启动引擎
        engine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
    }

    /**
     * register customer plugins
     */
    @JvmStatic
    fun registerPlugin(plugin: FlutterPlugin) {
        engine.plugins.add(plugin)
    }

    /**
     * The current flutter container Activity
     */
    @JvmStatic
    fun getCurrentActivity(): Activity? {
        return activityAwarePlugin.binding?.activity
    }

    /**
     * start native Activity,and request for Activity result
     */
    fun startNativeForResult(intent: Intent, callback: (result: HashMap<String, Any?>?) -> Unit) {
        val nextRequestCode = nextCode.getAndIncrement()
        getCurrentActivity()?.startActivityForResult(intent, nextRequestCode)
        ResultListener(activityAwarePlugin) { requestCode, resultCode, data ->
            if (requestCode == nextRequestCode && resultCode == Activity.RESULT_OK) {
                val map = hashMapOf<String, Any?>()
                data?.extras?.keySet()?.forEach {
                    map[it] = data.extras?.get(it)
                }
                callback.invoke(map)
            }
        }
    }

    /**
     *  open flutter page
     */
    @JvmStatic
    fun openFlutter(activity: Activity, routeName: String, params: HashMap<String, Any>? = null) {
        activity.startActivity(FaradayActivity.build(activity, routeName, params))
    }

    /**
     *  open flutter page,and request for result
     */
    @JvmStatic
    fun openFlutter(activity: Activity, routeName: String, requestCode: Int, params: HashMap<String, Any>? = null) {
        activity.startActivityForResult(FaradayActivity.build(activity, routeName, params), requestCode)
    }

}
