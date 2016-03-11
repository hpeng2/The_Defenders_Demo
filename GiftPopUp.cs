using System.Collections.Generic;
using UnityEngine;

public class DFWinRideGiftPopUp : GTWindow
{
    DFWinRideSub.RideGiftPopUpCallBack callback;
    public override void OnInit(object info)
    {
        if (info == null)
        {
            GTDebug.LogError("no passed callback");
        }
        else
        {
            GTDebug.LogError("no pass callback");
            callback = info as DFWinRideSub.RideGiftPopUpCallBack;
        }
        
    }
    void Start()
    {
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