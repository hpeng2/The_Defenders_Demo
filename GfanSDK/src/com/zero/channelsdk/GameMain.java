package com.zero.channelsdk;
import org.json.JSONException;
import org.json.JSONObject;

import com.mappn.sdk.pay.GfanConfirmOrderCallback;
import com.mappn.sdk.pay.GfanPay;
import com.mappn.sdk.pay.GfanPayCallback;
import com.mappn.sdk.pay.GfanPayInitCallback;
import com.mappn.sdk.pay.model.Order;
import com.mappn.sdk.uc.GfanUCCallback;
import com.mappn.sdk.uc.GfanUCenter;
import com.mappn.sdk.uc.User;
import com.unity3d.player.UnityPlayer;
import com.zero.defenders.UnityPlayerNativeActivity;
import com.zero.defenders.UnityPlayerNativeActivity.SdkType;

import android.util.Log;



public class GameMain extends BaseMain{
	
	UnityPlayerNativeActivity me = null;
	boolean mLogined = false;
	int mServerID = 0;
	
	public GameMain(UnityPlayerNativeActivity activity)
	{
		me = activity;
	}
	
	public void SwitchAccount(){
		UnityPlayer.UnitySendMessage("Platform","GameSwitchAccount" ,"");
	}
	public void reconnection(){
		sdkLogout();
		sdkLogin();
		

	}
	
	public void onKeyDown(){}
	
	public void Init() {
		me.SetShowAccount(true);
		GfanPay.getInstance(me.getApplicationContext()).init(me, new
				GfanPayInitCallback() {
				@Override
				public void onSuccess() {
					Log.e("Unity_gfan", "gfan:: sdk init success");
				//闪屏关闭成功
				}
				@Override
				public void onError() {
					
				}
				});
	}
	public void sdkLogin() {
		GfanUCenter.login(me, new GfanUCCallback() {
			@Override
			public void onSuccess(User user, int loginType) {
			// 由登录页登录成功
			if (GfanUCenter.RETURN_TYPE_LOGIN == loginType)
				{
				// TODO 登录成功处理
				// 由登录页注册成功
				}
				else
				{
				// TODO 注册成功处理
				}
				user.getUserName();
				user.getUid();
				Log.e("Unity_gfan", "gfan_" + user.getUid() + "Login*****");
				me.sdklogin("gfan_" + user.getUid());
				me.GameQuit();
			}
			@Override
			public void onError(int loginType) {
			// TODO 失败处理
				Log.e("Unity_gfan", "gfan:: sdk login error");
			}
			});
	}
	public void sdkLogout() {
		GfanUCenter.logout(me);
	}
	
	public void SdkSubmitExtendData(String jsonString) {
	}
	public void sdkExit() {
	}
	public void charge(String orderid, int amount ,int pro_id ,String pro_name ) 
	{
		amount = amount*10;
		Order order = new Order(pro_name, pro_name, amount, orderid);
		GfanPay.getInstance(me.getApplicationContext()).pay(order, new GfanPayCallback() {
		@Override
		public void onSuccess(User user, Order order) {
		// TODO消费成功处理
			Log.e("Unity_gfan", "gfan:: Recv Order Success");
		}
		@Override
		//如果返回失败，查询是否漏单
		public void onError(User user) {
			Log.e("Unity_gfan", "gfan:: Recv Order Error");
			GfanPay.getInstance(me.getApplicationContext()).confirmPay(new
					GfanConfirmOrderCallback() {
					@Override
					public void onExist(Order order) {
					// TODO 存在漏单
						Log.e("Unity_gfan", "gfan:: missing order existed");
					}
					@Override
					public void onNotExist() {
					// TODO 不存在漏单
					}
						
					});
		}
		});
		
	}
	// onStart Unity
	public void onStart() {
	}

	// Restart
	public void onRestart() {
	}

	// Resume Unity
	public void onResume() {
		
		
	}
	public void onPause() {
	}
	// Stop
	public void onStop() {
	}
	public void onDestroy()
	{
		
	}
	public SdkType GetSdkType()
	{
		//return null;//婵烇絽娴傞崰妤呭极婵傜绠ｉ柟閭︿海缁�瀣煠婵傚绨荤紒璁崇窔楠炴帡篓缁涚尛闂佹眹鍔岀�氼參鎮橀崶銊р枖闁跨噦鎷�
		return SdkType.Sdk_Gfan;
	}
}
