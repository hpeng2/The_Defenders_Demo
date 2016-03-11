using System.Collections.Generic;
using UnityEngine;

public class DFWinRideSub2 : GTWindow
{
    //string t1, t2, t3, t4, t5, t6, t7, t8;
    public static Dictionary<int, string> tlist = new Dictionary<int, string>();
    public static Dictionary<int, int> vlist = new Dictionary<int, int>();
    Transform t1, t2, t3, t4, t5, t6, t7, t8, v1, v2, v3, v4, v5, v6, v7, v8;
    void Start()
    {
        OpenTweenAlpha();

        tlist = DFModelRide.buff_title_list;
        vlist = DFModelRide.buff_soul_accumulated_list;


         t1 = transform.Find("index/hero/1/t");
         t2 = transform.Find("index/hero/2/t");
         t3 = transform.Find("index/hero/3/t");
         t4 = transform.Find("index/hero/4/t");
         t5 = transform.Find("index/hero/5/t");
         t6 = transform.Find("index/hero/6/t");
         t7 = transform.Find("index/pet/1/t");
         t8 = transform.Find("index/pet/2/t");

         v1 = transform.Find("index/hero/1/v");
         v2 = transform.Find("index/hero/2/v");
         v3 = transform.Find("index/hero/3/v");
         v4 = transform.Find("index/hero/4/v");
         v5 = transform.Find("index/hero/5/v");
         v6 = transform.Find("index/hero/6/v");
         v7 = transform.Find("index/pet/1/v");
         v8 = transform.Find("index/pet/2/v");

         LoadData();
         GTUIEventDispatcher.SetAllEventTargetToWindow(this);
         LoadComplete();
    }

    private void LoadData()
    {
        GTTools.ChangeLabeText(t1, "", tlist[5].ToString());
        GTTools.ChangeLabeText(t2, "", tlist[6].ToString());
        GTTools.ChangeLabeText(t3, "", tlist[7].ToString());
        GTTools.ChangeLabeText(t4, "", tlist[8].ToString());
        GTTools.ChangeLabeText(t5, "", tlist[9].ToString());
        GTTools.ChangeLabeText(t6, "", tlist[10].ToString());
        GTTools.ChangeLabeText(t7, "", tlist[11].ToString());
        GTTools.ChangeLabeText(t8, "", tlist[12].ToString());

        GTTools.ChangeLabeText(v1, "", "+" + vlist[1].ToString());
        GTTools.ChangeLabeText(v2, "", "+" + vlist[2].ToString());
        GTTools.ChangeLabeText(v3, "", "+" + vlist[3].ToString());
        GTTools.ChangeLabeText(v4, "", "+" + vlist[4].ToString());
        GTTools.ChangeLabeText(v5, "", "+" + (vlist[5] / 100).ToString() + "%");
        GTTools.ChangeLabeText(v6, "", "+" + (vlist[6] / 100).ToString() + "%");
        GTTools.ChangeLabeText(v7, "", "+" + (vlist[7] / 100).ToString() + "%");
        GTTools.ChangeLabeText(v8, "", "+" + (vlist[8] / 100).ToString() + "%");

    }

    void OnClickClose(GTUIEventDispatcher.Event e)
    {
        CloseTweenAlpha();
    }

    void OnPressClose(GTUIEventDispatcher.Event e)
    {
        GTTools.ChangeSprite(transform.Find("index/close").gameObject, "close_small_press");
    }
}