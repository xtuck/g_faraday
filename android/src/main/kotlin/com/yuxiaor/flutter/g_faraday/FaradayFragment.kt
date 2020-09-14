package com.yuxiaor.flutter.g_faraday

import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.TransparencyMode
import io.flutter.embedding.engine.FlutterEngine

/**
 * Author: Edward
 * Date: 2020-09-07
 * Description:
 */
class FaradayFragment private constructor() : FlutterFragment() {

    private var seqId: Int? = null
    private val plugin = Faraday.faradayPlugin

    companion object {

        private const val ARGS_KEY = "_flutter_args"
        private const val ROUTE_KEY = "_flutter_route"

        @JvmStatic
        fun newInstance(routeName: String, params: HashMap<String, Any>? = null): FaradayFragment {
            val bundle = Bundle().apply {
                putString(ROUTE_KEY, routeName)
                putSerializable(ARGS_KEY, params)
                putString(ARG_FLUTTERVIEW_TRANSPARENCY_MODE, TransparencyMode.opaque.name)
            }
            return FaradayFragment().apply { arguments = bundle }
        }
    }


    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return Faraday.engine
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val route = arguments?.getString(ROUTE_KEY)
        require(route != null) { "route must not be null!" }
        val args = arguments?.getSerializable(ARGS_KEY)
        plugin.onPageCreate(route, args) {
            seqId = it
            plugin.onPageShow(it)
        }
    }


    override fun onHiddenChanged(hidden: Boolean) {
        if (!hidden) {
            seqId?.let { plugin.onPageShow(it) }
        } else {
            seqId?.let { plugin.onPageHidden(it) }
        }
        super.onHiddenChanged(hidden)
    }

    override fun onResume() {
        super.onResume()
        seqId?.let { plugin.onPageShow(it) }
    }

    override fun onPause() {
        super.onPause()
        seqId?.let { plugin.onPageHidden(it) }
    }

    override fun onDetach() {
        super.onDetach()
        seqId?.let { plugin.onPageDealloc(it) }
    }

    override fun onDestroy() {
        super.onDestroy()
        seqId?.let { plugin.onPageDealloc(it) }
    }

}