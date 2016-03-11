using UnityEngine;
using System.Collections;

public class DFWinRideSoulPopUp : GTWindow {

    DFWinRideSub.PopUpPassInfo pass_in_info;
    DFWinRideSub.RideGiftPopUpCallBack callback;
    int cost = -1;
    public override void OnInit(object info)
    {
        if (info == null)
        {
            //GTDebug.LogError("no passed callback");
        }
        else
        {
            //GTDebug.LogError("no pass callback");
            pass_in_info = info as DFWinRideSub.PopUpPassInfo;
            cost = pass_in_info.merit_needed;
            callback = pass_in_info.callback;

        }

    }
    void Start()
    {
        transform.Find("index/background_1/txt1").GetComponent<UILabel>().text = string.Format(Localization.Get("ride giftinfosubwin3"), cost.ToString());
        OpenTweenAlpha();

        GTUIEventDispatcher.SetAllEventTargetToWindow(this);
        LoadComplete();
    }

    void OnClickButton(GTUIEventDispatcher.Event e)
    {
        string name = e.sender.name;
        callback.Invoke(this, name);
    }
}
