using System.Collections.Generic;
using UnityEngine;

public class DFWinRideSub : GTWindow
{
    DFModelRide m_model;
    DFModelPlayer m_model_player;
    DFModelRide.Ride ride;
    DFWinRide ride_win_main;
    DFModelMall m_model_mall;

    private bool isGift;
    //private bool isclicking;

    Transform tab;
    Transform soul;
    Transform gift;

    bool isclicking = false;

    UITexture texture2;

    UILabel left1, left2, left3, left4, right1, right2, right3, right4,
            left_title, right_title, middle_title, ride_name, ride_title, gift_value, progress_value, cost_value, des_label;

    int player_add_gift_value; //玩家已经加入的天赋点数
    int player_gift_value; //玩家现有的天赋点数
    int gift_point_cost; //天赋需要消耗的天赋值
    int total_gift_cost;

    int gift_level;
    int soul_main; // soul chapter
    int soul_sub; // soul level
    int last_soul_chapter;
    int cur_soul_chapter;
    int last_soul_point;
    int cur_soul_point;
    int merit_have;
    int player_level;
    float prob; // gift probability to level up;

    bool continousAddingFlag;
    bool noNeedToShowAddSoulConfirmWindow = false;
    

    int[] unlock_level = new int[12];
    string[] unlock_chapter_name = new string[12];

    string[] gift_data = new string[8];

    string t_soul_pet_des;
    string t_soul_hero_des;
    int t_cost;
    string t_chapter_title;

    GameObject pass;
    GameObject nopass;
    GameObject gray_button;

    //int[] soul_cost_list; // each soul points cost of the chosen chapter

    RenderTextureCreator re;

    Transform effect_soul_select;
    Transform effect_soul_unlock;

    public class PopUpPassInfo
    {
        public RideGiftPopUpCallBack callback;
        public int merit_needed;
    }
    public delegate void RideGiftPopUpCallBack(GTWindow win, string button_name);
    void Awake()
    {
       
    }
    void Start()
    {
        ride_win_main = new DFWinRide();
        m_model = GTDataModelManager.GetInstance().GetModel(DFModelType.DFModelRide) as DFModelRide;
        m_model.AddView("RecvRideSoulUnlockReturn2",gameObject);
        m_model.AddView("RecvRideGiftInfoReturn", gameObject);
        m_model.AddView("RecvRideGiftAddReturn", gameObject);
        m_model.AddView("RecvRideFightInfoChg2", gameObject);
        m_model_mall = GTDataModelManager.GetInstance().GetModel(DFModelType.DFModelMall) as DFModelMall;
        m_model_mall.AddView("LeftBuyCountReturn",gameObject);
        m_model_mall.AddView("BuyReturnNotify", gameObject);
        ride = DFWinRide.Ride;
        if (ride == null)
        { 
            return;
        }
        soul_main = (int)ride.soul_level.x;
        soul_sub = (int)ride.soul_level.y;
        gift_level = ride.gift_level;
        //GTDebug.LogError("soul_main:" + soul_main.ToString() + "soul_sub:" + soul_sub.ToString());

        


        //加载存储重要UI资源
        tab = transform.Find("index/tab");
        soul = transform.Find("index/soul");
        gift = transform.Find("index/gift");

        pass = soul.Find("card/pass").gameObject;
        nopass = soul.Find("card/nopass").gameObject;
        gray_button = soul.Find("card/nopass/btn_dis").gameObject;

        



        //加载天赋界面资源
        left1 = gift.Find("left/1").GetComponent<UILabel>();
        left2 = gift.Find("left/2").GetComponent<UILabel>();
        left3 = gift.Find("left/3").GetComponent<UILabel>();
        left4 = gift.Find("left/4").GetComponent<UILabel>();
        right1 = gift.Find("right/1").GetComponent<UILabel>();
        right2 = gift.Find("right/2").GetComponent<UILabel>();
        right3 = gift.Find("right/3").GetComponent<UILabel>();
        right4 = gift.Find("right/4").GetComponent<UILabel>();
        left_title = gift.Find("left/title").GetComponent<UILabel>();
        right_title = gift.Find("right/title").GetComponent<UILabel>();
        middle_title = gift.Find("middle/title").GetComponent<UILabel>();
        ride_name = gift.Find("middle/board/name").GetComponent<UILabel>();
        ride_title = gift.Find("middle/board/title").GetComponent<UILabel>();
        gift_value = gift.Find("middle/gift_value").GetComponent<UILabel>();
        progress_value = gift.Find("middle/bar/v").GetComponent<UILabel>();
        cost_value = gift.Find("middle/cost").GetComponent<UILabel>();
        des_label = gift.Find("middle/des3").GetComponent<UILabel>();
        merit_have = DFWinRide.merit_have;
        player_gift_value = Bag_Info.GetInstance().getItemCountInBag(1550210009);
        player_level = DFWinRide.player_level;
        SetCorrectTab();
        
        OpenTweenPositionFromBottom(0, 0);
        OpenBanner();

        SwitchTab();

        GTUIEventDispatcher.SetAllEventTargetToWindow(this);
        DFWinBanner winbanner = new DFWinBanner();
        //winbanner.RegisterReturn(this,false)
        LoadComplete();
    }
    public void rideGiftPopUpCallback(GTWindow win, string name)
    {
        Transform soul_tab = tab.Find("soul_tab");
        Transform gift_tab = tab.Find("gift_tab");

        if (name == "btn_leave")
        {
            DFWinRide.TAB_GIFT = false;
            isGift = false;
            soul.gameObject.SetActive(true);
            gift.gameObject.SetActive(false);
            soul_tab.Find("select").gameObject.SetActive(true);
            gift_tab.Find("select").gameObject.SetActive(false);
            re.Release();
            SwitchTab();
            win.CloseTweenAlpha();
        }
        else if (name == "btn_continue")
        {
            win.CloseTweenAlpha();
            return;
        }
    }
    private void SwitchTab()
    {
        if (DFWinRide.TAB_GIFT == true)
        {
            gift.Find("middle/btn_gift/zuoqi_tianfu_zhuru").gameObject.SetActive(false);
            gift.Find("zuoqi_tianfu_shifangliuguang").gameObject.SetActive(false);
            gift.Find("zuoqi_tianfu_shuidi").gameObject.SetActive(false);

            texture2 = gift.Find("middle/model").GetComponent<UITexture>();
            re = RenderTextureCreator.create(texture2.gameObject, 250, 250);
            texture2.uvRect = new Rect(0, 0, 1, 1);
            texture2.gameObject.AddComponent<GTUIEventDispatcher>().onDrag = "OnDragCollider";
            texture2.gameObject.AddComponent<BoxCollider>().size = texture2.localSize;

            re.DelModels();
            Character.getBody(ride.ride_id, GetBodyCallBackGift);
            gift_value.text = player_gift_value.ToString();
            PBMessage.GM_HorseGiftInfoRequest rr = new PBMessage.GM_HorseGiftInfoRequest();
            rr.horsegmid = ride.gm_id;
            m_model.UpdateModel("SendRideGiftInfoRequest", rr);

            //LoadGiftMain();
            
        }
        else
        {
            texture2 = soul.Find("left/model").GetComponent<UITexture>();
            re = RenderTextureCreator.create(texture2.gameObject, 250, 250);
            texture2.uvRect = new Rect(0, 0, 1, 1);
            texture2.gameObject.AddComponent<GTUIEventDispatcher>().onDrag = "OnDragCollider";
            texture2.gameObject.AddComponent<BoxCollider>().size = texture2.localSize;

            ReadSoulExtraData();
            unlock_level = DFModelRide.soul_unlock_level_list;
            unlock_chapter_name = DFModelRide.soul_chapter_name;
            LoadSoulMain();
        }
    }

    void RecvRideFightInfoChg2(PBMessage.GM_HorseAddFightChange p)
    {
        if (isGift == true)
        {
            //GTDebug.LogError("updating gift list");
            LoadGiftMain();
        }

    }

    void RecvRideGiftInfoReturn(PBMessage.GM_HorseGiftInfoReturn p)
    {
        if (p.m_result == 0)
        {
            player_add_gift_value = p.giftmolecule;
            prob = (float)p.upprobility / (float)10000;
            LoadProbability();
            LoadGiftMain();
        }
        else
        {
            Close();
            GTDebug.LogError("RecvRideGiftInfoReturn not success");
        }
        
    }

    private void LoadProbability()
    {
        UILabel txt = gift.Find("middle/des2").GetComponent<UILabel>();
        if (prob <= 0.02)
        {
            txt.text = Localization.Get("ride hasprobtoupgrad1");
        }
        else if (prob > 0.02 && prob <= 0.04)
        {
            txt.text = Localization.Get("ride hasprobtoupgrad2");
        }
        else if (prob > 0.04 && prob <= 0.06)
        {
            txt.text = Localization.Get("ride hasprobtoupgrad3");
        }
        else
        {
            txt.text = Localization.Get("ride hasprobtoupgrad4");
        }
    }
    private void LoadGiftMain()
    {
        

        ReadGiftData();
        SetGiftBar();
        UILabel[] labels = { left1, left2, left3, left4, right1, right2, right3, right4 };
        for (int i = 0; i < labels.Length; i++)
        {
            labels[i].text = gift_data[i];
        }
        left_title.text = Localization.Get("ride gift") + gift_level.ToString() + Localization.Get("ride level");
        middle_title.text = Localization.Get("ride gift") + gift_level.ToString() + Localization.Get("ride level");
        right_title.text = Localization.Get("ride gift") + (gift_level+1).ToString() + Localization.Get("ride level");
        ride_name.text = ride.ride_name;
        progress_value.text = player_add_gift_value.ToString() + " / " + total_gift_cost.ToString();
        des_label.text = string.Format(Localization.Get("ride giftdescribe"), gift_point_cost.ToString() + ",");

    }

    private void ReadGiftData()
    {

        if (gift_level == 0)
        {
            string sql = "select * from type_mounts_talent where level = {0};";
            sql = string.Format(sql, gift_level+1);
            var rr = GTDataBaseManager.GetInstance().Query(sql);
            while (rr.Step())
            {
                

                for (int i = 0; i < 4; i++)
                {

                    int propertyid = rr.GetInt("property" + (i + 1).ToString() + "_type");
                    int propertyvalue = rr.GetInt("property" + (i + 1).ToString() + "_value");
                    string sql1 = "select * from type_attribute_text where fight_attribute = {0}";
                    sql1 = string.Format(sql1, propertyid);
                    var rr1 = GTDataBaseManager.GetInstance().Query(sql1);
                    while (rr1.Step())
                    {
                        gift_data[i] = rr1.GetString("text") + " + 0";
                    }
                    rr1.Release();
                }
            }
            rr.Release();
        }
        else
        {
            string sql = "select * from type_mounts_talent where level = {0};";
            sql = string.Format(sql, gift_level);
            var rr = GTDataBaseManager.GetInstance().Query(sql);
            while (rr.Step())
            {
                for (int i = 0; i < 4; i++)
                {

                    int propertyid = rr.GetInt("property" + (i + 1).ToString() + "_type");
                    int propertyvalue = rr.GetInt("property" + (i + 1).ToString() + "_value");
                    string sql1 = "select * from type_attribute_text where fight_attribute = {0}";
                    sql1 = string.Format(sql1, propertyid);
                    var rr1 = GTDataBaseManager.GetInstance().Query(sql1);
                    while (rr1.Step())
                    {
                        gift_data[i] = rr1.GetString("text") + " + " + propertyvalue.ToString();
                    }
                    rr1.Release();
                }
            }
            rr.Release();
        }
        

        int next_level = gift_level + 1;
        if (next_level == 81)
        {
            next_level = 80;
        }

        //next level
        string sql2 = "select * from type_mounts_talent where level = {0};";
        sql2 = string.Format(sql2, next_level);
        var rr2 = GTDataBaseManager.GetInstance().Query(sql2);
        while (rr2.Step())
        {
            gift_point_cost = rr2.GetInt("cost_value_inc");
            for (int i = 0; i < 4; i++)
            {
                total_gift_cost = rr2.GetInt("cost_value");
                int propertyid = rr2.GetInt("property" + (i + 1).ToString() + "_type");
                int propertyvalue = rr2.GetInt("property" + (i + 1).ToString() + "_value");
                string sql1 = "select * from type_attribute_text where fight_attribute = {0}";
                sql1 = string.Format(sql1, propertyid);
                var rr1 = GTDataBaseManager.GetInstance().Query(sql1);
                while (rr1.Step())
                {
                    gift_data[i+4] = rr1.GetString("text") + " +" + propertyvalue.ToString();
                }
                rr1.Release();
            }
        }
        rr2.Release();
    }
    private void ReadSoulData()
    {
        string sql = "select * from type_mounts_soul where main_type = {0} and sub_type = {1};";
        sql = string.Format(sql, cur_soul_chapter, cur_soul_point);
        var rr = GTDataBaseManager.GetInstance().Query(sql);
        while (rr.Step())
        {
            t_chapter_title = rr.GetString("main_type_name");
            t_cost = rr.GetInt("cost_value");
            t_soul_hero_des = rr.GetString("describe");
        }
        
        rr.Release();
    }

    private void ReadSoulExtraData()
    {
        string sql = "select * from type_mounts_soul_extra where mounts_id = {0} and soul_type = {1};";
        sql = string.Format(sql, ride.ride_id, cur_soul_chapter);
        var rr = GTDataBaseManager.GetInstance().Query(sql);
        while (rr.Step())
        {
            t_soul_pet_des = rr.GetString("describe");
        }

        rr.Release();
    }

    private void LoadSoulMain()
    {
        //加载坐骑模型
        re.DelModels();
        Character.getBody(ride.ride_id, GetBodyCallBack);

        UILabel name = soul.Find("left/des/text").GetComponent<UILabel>();
        //GTDebug.LogError(ride.ride_name);
        name.text = ride.ride_name;

        LoadSoulTopList();
    }

    void GetBodyCallBack(GameObject o)
    {
        if (o != null)
        {
            if (re != null)
            {
                re.AddModel(o, "model", new Vector3(0F, -0.84f, 4F), new Vector3(0, 140, 0));
            }
        }

    }

    void GetBodyCallBackGift(GameObject o)
    {
        if (o != null)
        {
            if (re != null)
            {
                re.AddModel(o, "model", new Vector3(0F, -0.84f, 4F), new Vector3(0, -158.5f, 0));
            }
        }

    }
    /// <summary>
    /// 从坐骑主界面加载对应的Tab
    /// </summary>
    private void SetCorrectTab()
    {
        Transform soul_tab = tab.Find("soul_tab");
        Transform gift_tab = tab.Find("gift_tab");
        if (DFWinRide.TAB_GIFT == true)
        {
            isGift = true;
            gift.gameObject.SetActive(true);
            soul.gameObject.SetActive(false);
            soul_tab.Find("select").gameObject.SetActive(false);
            gift_tab.Find("select").gameObject.SetActive(true);
        }
        else
        {
            isGift = false;
            gift.gameObject.SetActive(false);
            soul.gameObject.SetActive(true);
            soul_tab.Find("select").gameObject.SetActive(true);
            gift_tab.Find("select").gameObject.SetActive(false);
        }

        if (player_level < 40)
        {
            gift_tab.Find("lock").gameObject.SetActive(true);
        }
    }
    /// <summary>
    /// 玩家点击英魂按钮呼叫的函数
    /// </summary>
    /// <param name="e"></param>
    private void OnClickSoul(GTUIEventDispatcher.Event e)
    {
        Transform soul_tab = tab.Find("soul_tab");
        Transform gift_tab = tab.Find("gift_tab");
        if (isGift == true)
        {
            if (player_add_gift_value > 0)
            {
                RideGiftPopUpCallBack rb = rideGiftPopUpCallback;
                GTUIManager.OpenWindow(scene, typeof(DFWinRideGiftPopUp), "ui/ride/ride_sub_2", GTWindow.Layer.Window, 0, true, GTUIManager.CoverType.None, null, rb);
            }
            else
            {
                DFWinRide.TAB_GIFT = false;
                isGift = false;
                soul.gameObject.SetActive(true);
                gift.gameObject.SetActive(false);
                soul_tab.Find("select").gameObject.SetActive(true);
                gift_tab.Find("select").gameObject.SetActive(false);
                re.Release();
                SwitchTab();
            }
        }
    }

    private void ButtonCallBack(GTWindow win)
    {
        throw new System.NotImplementedException();
    }
    /// <summary>
    /// 玩家点击天赋按钮呼叫的函数
    /// </summary>
    /// <param name="e"></param>
    private void OnClickGift(GTUIEventDispatcher.Event e)
    {
        Transform soul_tab = tab.Find("soul_tab");
        Transform gift_tab = tab.Find("gift_tab");

        if (player_level < m_model.gift_unlock_level)
        {
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride nopassgiftenter"), GTUIManager.DialogType.AutoClose, null);
            return;
        }

        if (isGift == false)
        {
            //
            soul.Find("card/" + cur_soul_chapter.ToString() + "/" + cur_soul_point.ToString() + "/select").gameObject.SetActive(false);
            soul.Find("card/" + cur_soul_chapter.ToString()).gameObject.SetActive(false);
            soul.Find("left/scroll/grid/" + cur_soul_chapter.ToString() + "/select").gameObject.SetActive(false);
            //

            DFWinRide.TAB_GIFT = true;
            isGift = true;
            soul.gameObject.SetActive(false);
            gift.gameObject.SetActive(true);
            soul_tab.Find("select").gameObject.SetActive(false);
            gift_tab.Find("select").gameObject.SetActive(true);
            re.Release();
            SwitchTab();
        }
    }

    private void LoadSoulTopList()
    {
        Transform entry = soul.Find("left/scroll/grid/a");

        int childnum = soul.Find("left/scroll/grid").childCount;
        if (childnum == 1) 
        {
            for (int i = 1; i <= 12; i++)
            {
                Transform clone = GTTools.Clone(entry, i.ToString(), false).transform;
                clone.Find("text").GetComponent<UILabel>().text = unlock_chapter_name[i - 1];
                if (player_level >= unlock_level[i - 1])
                {
                    if ((soul_main == 1 && soul_sub == 5 && i == soul_main + 1) || (soul_main == 2 && soul_sub == 6 && i == soul_main + 1) || (soul_main >= 3 && soul_sub == 8 && i == soul_main + 1))
                    {
                        SetIconColor(clone, true);
                    }
                    else if (i <= (soul_main))
                    {
                        SetIconColor(clone, true);
                    }
                    else
                    {
                        SetIconColor(clone, false);
                    }
                }
                else
                {
                    SetIconColor(clone, false);
                }


            }
        } 
        
        
        soul.Find("left/scroll/grid").GetComponent<UIGrid>().Reposition();
        ScrollToProperPosition();
        
        LoadDefaultLayout();
    }

    private void ScrollToProperPosition()
    {
        float fraction = ((float)soul_main) * (1f/7f) - (3f/7f);
        soul.Find("left/scroll").GetComponent<UIScrollView>().SetDragAmount(fraction, 0, false);
        //if (soul_main <= 3)
        //{
        //    soul.Find("left/scroll").GetComponent<UIScrollView>().SetDragAmount(0, 0, false);
        //}
        //else if (soul_main >= 10)
        //{
        //    soul.Find("left/scroll").GetComponent<UIScrollView>().SetDragAmount(1, 0, false);
        //}
        //else
        //{
            //fraction = fraction - 0.2845f;
            
        //}
        //GTDebug.LogError(fraction.ToString());
    }
    


    private void LoadDefaultLayout()
    {
        
        cur_soul_point = soul_sub + 1;
        cur_soul_chapter = soul_main;

        if ((cur_soul_chapter == 1 && cur_soul_point == 6) || (cur_soul_chapter == 2 && cur_soul_point == 7) || (cur_soul_chapter >= 3 && cur_soul_point == 9))
        {
            cur_soul_point = soul_sub;
        }
        ReadSoulExtraData();
        soul.Find("left/scroll/grid/" + cur_soul_chapter.ToString() + "/select").gameObject.SetActive(true);
        soul.Find("card/" + cur_soul_chapter.ToString() + "/" + cur_soul_point.ToString() + "/select").gameObject.SetActive(true);
        soul.Find("card/" + cur_soul_chapter.ToString() + "/ex/t").GetComponent<UILabel>().text = t_soul_pet_des;
        LoadSoulSelectEffect(cur_soul_chapter, cur_soul_point);

        last_soul_point = cur_soul_point;
        last_soul_chapter = cur_soul_chapter;

        LoadSoulPattern();
        LoadSoulCardDescribe();
    }

    void AutomaticLoadNextSoulChapter()
    {
        
        //if (player_level >= unlock_level[cur_soul_chapter - 1])
        //{
        //    if (soul_main < 12)
        //    {
        //        cur_soul_chapter = soul_main + 1;

        //    }
            cur_soul_chapter = soul_main + 1;
            soul.Find("card/" + last_soul_chapter.ToString() + "/" + last_soul_point.ToString() + "/select").gameObject.SetActive(false);
            soul.Find("card/" + last_soul_chapter.ToString()).gameObject.SetActive(false);
            soul.Find("left/scroll/grid/" + last_soul_chapter.ToString() + "/select").gameObject.SetActive(false);
            soul.Find("card/" + cur_soul_chapter.ToString()).gameObject.SetActive(true);
            soul.Find("left/scroll/grid/" + cur_soul_chapter.ToString() + "/select").gameObject.SetActive(true);
            cur_soul_point = 1;
            last_soul_point = 1;
            ReadSoulExtraData();
            soul.Find("card/" + cur_soul_chapter.ToString() + "/" + cur_soul_point.ToString() + "/select").gameObject.SetActive(true);
            soul.Find("card/" + cur_soul_chapter.ToString() + "/ex/t").GetComponent<UILabel>().text = t_soul_pet_des;
            //last_soul_chapter = cur_soul_chapter;
            LoadSoulPattern();
            LoadSoulCardDescribe();
            last_soul_chapter = cur_soul_chapter;
        //}

        
    }


    void OnClickSoulChapter(GTUIEventDispatcher.Event e)
    {      
        last_soul_chapter = cur_soul_chapter;
        cur_soul_chapter = int.Parse(e.sender.name);
        if (cur_soul_chapter != last_soul_chapter)
        {
            soul.Find("card/" + last_soul_chapter.ToString() + "/" + last_soul_point.ToString() + "/select").gameObject.SetActive(false);
            if (player_level >= unlock_level[cur_soul_chapter - 1])
            {
                if (cur_soul_chapter < (soul_main + 1))
                {
                    soul.Find("card/" + last_soul_chapter.ToString()).gameObject.SetActive(false);
                    soul.Find("left/scroll/grid/" + last_soul_chapter.ToString() + "/select").gameObject.SetActive(false);
                    soul.Find("card/" + cur_soul_chapter.ToString()).gameObject.SetActive(true);
                    soul.Find("left/scroll/grid/" + cur_soul_chapter.ToString() + "/select").gameObject.SetActive(true);

                    cur_soul_point = 1;
                    last_soul_point = 1;
                    soul.Find("card/" + cur_soul_chapter.ToString() + "/" + cur_soul_point.ToString() + "/select").gameObject.SetActive(true);
                    ReadSoulExtraData();
                    soul.Find("card/" + cur_soul_chapter.ToString() + "/ex/t").GetComponent<UILabel>().text = t_soul_pet_des;
                    //last_soul_chapter = cur_soul_chapter;
                    LoadSoulPattern();
                    LoadSoulCardDescribe();
                } 
                else if (cur_soul_chapter == soul_main + 1) 
                {
                    if ((soul_main == 1 && soul_sub == 5) || (soul_main == 2 && soul_sub == 6) || (soul_main >= 3 && soul_sub == 8))
                    {
                        soul.Find("card/" + last_soul_chapter.ToString()).gameObject.SetActive(false);
                        soul.Find("left/scroll/grid/" + last_soul_chapter.ToString() + "/select").gameObject.SetActive(false);
                        soul.Find("card/" + cur_soul_chapter.ToString()).gameObject.SetActive(true);
                        soul.Find("left/scroll/grid/" + cur_soul_chapter.ToString() + "/select").gameObject.SetActive(true);
                        cur_soul_point = 1;
                        last_soul_point = 1;
                        soul.Find("card/" + cur_soul_chapter.ToString() + "/" + cur_soul_point.ToString() + "/select").gameObject.SetActive(true);
                        ReadSoulExtraData();
                        soul.Find("card/" + cur_soul_chapter.ToString() + "/ex/t").GetComponent<UILabel>().text = t_soul_pet_des;
                        //last_soul_chapter = cur_soul_chapter;
                        LoadSoulPattern();
                        LoadSoulCardDescribe();
                    }
                    else
                    {
                        string str = string.Format(Localization.Get("ride notunlockprevioussoul"), unlock_level[cur_soul_chapter - 1].ToString());
                        cur_soul_chapter = last_soul_chapter;
                        GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + str, GTUIManager.DialogType.AutoClose, null);
                        soul.Find("card/" + last_soul_chapter.ToString() + "/" + last_soul_point.ToString() + "/select").gameObject.SetActive(true);
                    }
                }
                else
                { 
                    //解锁前面战魂弹窗
                    string str = string.Format(Localization.Get("ride notunlockprevioussoul"), unlock_level[cur_soul_chapter - 1].ToString());
                    GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + str, GTUIManager.DialogType.AutoClose, null);
                    cur_soul_chapter = last_soul_chapter;
                    soul.Find("card/" + last_soul_chapter.ToString() + "/" + last_soul_point.ToString() + "/select").gameObject.SetActive(true);
                }
            }
            else
            {
                //等级不足弹窗
                string str = string.Format(Localization.Get("ride notunlockprevioussoul"), unlock_level[cur_soul_chapter - 1].ToString());
                GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + str, GTUIManager.DialogType.AutoClose, null);
                cur_soul_chapter = last_soul_chapter;
                soul.Find("card/" + last_soul_chapter.ToString() + "/" + last_soul_point.ToString() + "/select").gameObject.SetActive(true);
            }

            LoadSoulSelectEffect(cur_soul_chapter, cur_soul_point);   
        }
        last_soul_chapter = cur_soul_chapter;
        

        
    }

    void OnClickDetail(GTUIEventDispatcher.Event e)
    {

    }

    private void LoadSoulCardDescribe()
    {
        ReadSoulData();

        Transform card = soul.Find("card");
        UILabel titleLabel = card.Find("title").GetComponent<UILabel>();
        titleLabel.text = t_chapter_title;
        UILabel describeNameLabel = card.Find("des_effect").GetComponent<UILabel>();
        describeNameLabel.text = t_soul_hero_des;
        UILabel cost_value = card.Find("nopass/consume_num").GetComponent<UILabel>();
        cost_value.text =  t_cost.ToString();
        UILabel describePetEffect = card.Find("des_pet_effect").GetComponent<UILabel>();
        describePetEffect.text = t_soul_pet_des;


        if (cur_soul_chapter == soul_main)
        {
            if (cur_soul_point <= soul_sub) // || (soul_main == 1 && cur_soul_point == 6) || (soul_main == 2 && cur_soul_point == 7) || (soul_main >= 3 && cur_soul_point == 9)
            {
                nopass.SetActive(false);
                pass.SetActive(true);
                gray_button.SetActive(false);
            }
            else if (cur_soul_point == soul_sub+1)
            {
                nopass.SetActive(true);
                pass.SetActive(false);
                gray_button.SetActive(false);
            }
            else
            {
                nopass.SetActive(true);
                pass.SetActive(false);
                gray_button.SetActive(true);
            }
        } 
        else if( (soul_main == 1 && soul_sub == 5 && cur_soul_chapter == 2 && cur_soul_point == 1) ||
                   (soul_main == 2 && soul_sub == 6 && cur_soul_chapter == 3 && cur_soul_point == 1) ||
                   (soul_main >= 3 && soul_sub == 8 && cur_soul_chapter == soul_main+1 && cur_soul_point == 1))
        {
            nopass.SetActive(true);
            pass.SetActive(false);
            gray_button.SetActive(false);
        }
        else if (cur_soul_chapter > soul_main)
        {
            nopass.SetActive(true);
            pass.SetActive(false);
            gray_button.SetActive(true);
        }
        else
        {
            nopass.SetActive(false);
            pass.SetActive(true);
            gray_button.SetActive(false);
        }

        if ((cur_soul_chapter == 1 && cur_soul_point == 5) || (cur_soul_chapter == 2 && cur_soul_point == 6) || (cur_soul_chapter >= 3 && cur_soul_point == 8))
        {
            soul.Find("card/des_pet_name").gameObject.SetActive(true);
            soul.Find("card/des_pet_effect").gameObject.SetActive(true);
        }
        else
        {
            soul.Find("card/des_pet_name").gameObject.SetActive(false);
            soul.Find("card/des_pet_effect").gameObject.SetActive(false);
        }

    }


    void LoadSoulPattern()
    {
        Transform list = soul.Find("card/" + cur_soul_chapter.ToString());
        int count;
        if (cur_soul_chapter == 1)
        {
            count = 4;
        }
        else if (cur_soul_chapter == 2)
        {
            count = 5;
        }
        else
        {
            count = 7;
        }
        if (cur_soul_chapter > soul_main)
        {
            for (int i = 1; i <= count; i++)
            {
                UISprite sp = list.Find(i.ToString()).GetComponent<UISprite>();
                sp.spriteName = "lock_small";
            }
            UISprite sp1 = list.Find((count + 1).ToString()).GetComponent<UISprite>();
            sp1.spriteName = "lock_big";
        }

        else if (cur_soul_chapter < soul_main)
        {
            for (int i = 1; i <= count; i++)
            {
                UISprite sp = list.Find(i.ToString()).GetComponent<UISprite>();
                sp.spriteName = "soul_small";
                LoadSoulhasunlockedEffect(cur_soul_chapter, i);
            }
            UISprite sp1 = list.Find((count + 1).ToString()).GetComponent<UISprite>();
            GTTools.ChangeSprite(sp1.gameObject, "soul_small");
            LoadSoulhasunlockedEffect(cur_soul_chapter, count+1);
        }
        else
        {
            for (int i = 1; i <= count; i++)
            {
                UISprite sp = list.Find(i.ToString()).GetComponent<UISprite>();
                if (i > soul_sub+1)
                {
                    sp.spriteName = "lock_small";
                }
                else if (i < soul_sub+1)
                {
                    GTTools.ChangeSprite(sp.gameObject, "soul_small");
                    LoadSoulhasunlockedEffect(cur_soul_chapter, i);
                }
                else
                {
                    sp.spriteName = "unlock_small";
                }

            }
            UISprite sp1 = list.Find((count + 1).ToString()).GetComponent<UISprite>();
            if ((count + 1) > soul_sub+1)
            {
                sp1.spriteName = "lock_big";
            }
            else if ((count + 1) < soul_sub+1)
            {
                GTTools.ChangeSprite(sp1.gameObject, "soul_small");
                LoadSoulhasunlockedEffect(cur_soul_chapter, count+1);
            }
            else
            {
                sp1.spriteName = "unlock_big";
            }
        }
        list.gameObject.SetActive(true);

    }

    void OnClickSoulPoint(GTUIEventDispatcher.Event e)
    {
        Transform list = soul.Find("card/" + cur_soul_chapter.ToString());
        last_soul_point = cur_soul_point;
        cur_soul_point = int.Parse(e.sender.name);
        if (cur_soul_point != last_soul_point)
        {
            
            
            list.Find(cur_soul_point.ToString() + "/select").gameObject.SetActive(true);
            list.Find(last_soul_point.ToString() + "/select").gameObject.SetActive(false);
            LoadSoulCardDescribe();
            LoadSoulSelectEffect(cur_soul_chapter, cur_soul_point);
            
        }
        last_soul_point = cur_soul_point;
    }

    void LoadSoulSelectEffect(int cur_main, int cur_sub)
    {
        Transform list = soul.Find("card/" + cur_main.ToString() + "/" + cur_sub.ToString());
        if (effect_soul_select == null)
        {
            effect_soul_select = soul.Find("zuoqi_yinghun_kedian");
            effect_soul_select.gameObject.SetActive(true);
        }
        effect_soul_select.parent = list;
        effect_soul_select.localPosition = new Vector3(-208.7f, -55.3f);
        effect_soul_select.localScale = new Vector3(350, 350, 1);
    }

    void Update()
    {
        if (continousAddingFlag == true)
        {
            if (isclicking == false)
            {
                if (player_gift_value >= gift_point_cost)
                {
                    PBMessage.GM_HorseGiftLvUpRequest rr = new PBMessage.GM_HorseGiftLvUpRequest();
                    rr.horsegmid = ride.gm_id;
                    m_model.UpdateModel("SendRideGiftAddRequest", rr);
                    isclicking = true;
                }
                else
                {
                    m_model_mall.UpdateModel("RequestBuyCountLeft", 1550210009);
                    isclicking = true;
                }
            }
        }
    }

    void OnClickAddGift(GTUIEventDispatcher.Event e)
    {
        //GTDebug.LogError("called");

        if (e.press_is_down == true)
        {
            continousAddingFlag = true;
            if (isclicking == false)
            {
                
                if (player_gift_value >= gift_point_cost)
                {
                    PBMessage.GM_HorseGiftLvUpRequest rr = new PBMessage.GM_HorseGiftLvUpRequest();
                    rr.horsegmid = ride.gm_id;
                    m_model.UpdateModel("SendRideGiftAddRequest", rr);
                    isclicking = true;
                }
                else
                {
                    m_model_mall.UpdateModel("RequestBuyCountLeft", 1550210009);
                    isclicking = true;
                }
                
            }
        }
        else
        {
            continousAddingFlag = false;
        }
    }

    void LeftBuyCountReturn(PBMessage.GM_BuyCountLeftResult p)
    {
        if (p.m_leftcount > 0)
        {
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" +Localization.Get("ride giftgotomaill"), GTUIManager.DialogType.OKCancel, SetConfirm);
        }
        else
        {
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride giftpointnotenough"), GTUIManager.DialogType.AutoClose, null);
            isclicking = false;
        }
        
    }


    void SetConfirm(GTWindow win, GTUIManager.DialogButton button)
    {
        switch (button)
        {
            case GTUIManager.DialogButton.Cancel:
                break;
            case GTUIManager.DialogButton.OK:
                GTUIManager.OpenWindowWithCoverBlur(scene, typeof(DFWinMallMainPanel), "ui/mall/mall", null);
                break;
            
        }
        isclicking = false;
    }

    void BuyReturnNotify(PBMessage.GM_BuyResult p)
    {
        if (p.m_result == 0)
        {
            player_gift_value = Bag_Info.GetInstance().getItemCountInBag(1550210009);
            gift_value.text = player_gift_value.ToString();
        }
    }

    void RecvRideGiftAddReturn(PBMessage.GM_HorseGiftLevelUpReturn p)
    {
        if (p.m_result == 0)
        {
            continousAddingFlag = false;
            GameObject effect = gift.Find("middle/btn_gift/zuoqi_tianfu_zhuru").gameObject;
            effect.SetActive(false);
            effect.SetActive(true);
            //GTDebug.LogError("level:: " + p.newupprobility.ToString());
            gift_level++;
            ride.gift_level++;
            player_add_gift_value = 0;
            SetGiftBar();
            prob = (float) p.newupprobility / (float)10000;
            LoadProbability();
            gift_value.text = (player_gift_value - gift_point_cost).ToString();
            player_gift_value -= gift_point_cost;
            LoadGiftMain();

            GameObject effect1 = gift.Find("zuoqi_tianfu_shifangliuguang").gameObject;
            effect1.SetActive(false);
            effect1.SetActive(true);
            Invoke("GiftUpgradEffect", 0.25f);
        } 
        else if (p.m_result == 1)
        {
            GameObject effect = gift.Find("middle/btn_gift/zuoqi_tianfu_zhuru").gameObject;
            effect.SetActive(false);
            effect.SetActive(true);
            //GTDebug.LogError("ppnolevel:: " + p.newupprobility.ToString());
            progress_value.text = p.newGiftValue.ToString() + " / " + total_gift_cost.ToString();
            player_add_gift_value = p.newGiftValue;
            SetGiftBar();
            prob = (float)p.newupprobility / (float)10000;
            LoadProbability();

            int value = player_gift_value - gift_point_cost;
            if (value < 0)
            {
                value = 0;
            }
            gift_value.text = value.ToString();
            player_gift_value -= gift_point_cost;
            isclicking = false;

            
        }
        else if (p.m_result == 2)
        {
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride giftpointnotenough"), GTUIManager.DialogType.AutoClose, null);
            isclicking = false;
            
        }
        else if (p.m_result == 3)
        {
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride giftpointnotenough"), GTUIManager.DialogType.AutoClose, null);
            isclicking = false;
        }

        //int actual_gift = Bag_Info.GetInstance().getItemCountInBag(1550210009);
        //GTDebug.LogError("Actual_gift:" + actual_gift.ToString() + "  showing_gift:" + player_gift_value.ToString());
        
    }

    void GiftUpgradEffect()
    {
        GameObject effect = gift.Find("zuoqi_tianfu_shuidi").gameObject;
        effect.SetActive(false);
        effect.SetActive(true);
        Invoke("UpgradeEffectTime", 1f);
        
    }

    void UpgradeEffectTime()
    {
        
        isclicking = false;
    }

    void OnClickAddSoul(GTUIEventDispatcher.Event e)
    {
        bool pass = false;
        if (soul_main == 1 && soul_sub == 5)
        {
            if (cur_soul_chapter == 2 && cur_soul_point == 1)
            {
                pass = true;
            }
        }
        else if (soul_main == 2 && soul_sub == 6)
        {
            if (cur_soul_chapter == 3 && cur_soul_point == 1)
            {
                pass = true;
            } 
        }
        else if (soul_main >= 3 && soul_sub == 8)
        {
            if (cur_soul_chapter == soul_main+1 && cur_soul_point == 1)
            {
                pass = true;
            }
        }
        else
        {
            if (cur_soul_chapter == soul_main && cur_soul_point == soul_sub + 1)
            {
                pass = true;
            }
        }
        if (pass)
        {
            if (merit_have >= t_cost)
            {
                if (noNeedToShowAddSoulConfirmWindow == true)
                {
                    if (isclicking == false)
                    {
                        isclicking = true;
                        PBMessage.GM_HorseSoulUnlock rr = new PBMessage.GM_HorseSoulUnlock();
                        rr.horsegmid = ride.gm_id;
                        rr.chapter = cur_soul_chapter;
                        rr.level = cur_soul_point;
                        m_model.UpdateModel("SendRideSoulUnlockRequest", rr);
                    }
                    
                }
                else
                {
                    PopUpPassInfo info = new PopUpPassInfo();
                    info.merit_needed = t_cost;
                    info.callback = SetConfirm;
                    GTUIManager.OpenWindow(scene, typeof(DFWinRideSoulPopUp), "ui/ride/ride_sub_3", GTWindow.Layer.Window, 0, true, GTUIManager.CoverType.None, null, info);
                }
                
            }
            else
            {
                //弹窗 功勋值不足
                GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride unabletounlock"), GTUIManager.DialogType.AutoClose, null);
            }
        }
        
    }

    void SetConfirm(GTWindow win, string button)
    {
        if (button == "btn_leave")
        {
            win.CloseTweenAlpha();
            return;
        }
        else if (button == "btn_continue")
        {
            if (isclicking == false)
            {
                noNeedToShowAddSoulConfirmWindow = true;
                isclicking = true;
                PBMessage.GM_HorseSoulUnlock rr = new PBMessage.GM_HorseSoulUnlock();
                rr.horsegmid = ride.gm_id;
                rr.chapter = cur_soul_chapter;
                rr.level = cur_soul_point;
                m_model.UpdateModel("SendRideSoulUnlockRequest", rr);
                win.CloseTweenAlpha();
            }
        }
    }

    void RecvRideSoulUnlockReturn2(PBMessage.GM_HorseSoulUnlockReturn p)
    {
        if (p.m_result == 0)
        {

            LoadUnlockSoulEffect();

            merit_have -= t_cost;
            GTTools.ChangeSprite(soul.Find("card/" + cur_soul_chapter.ToString() + "/" + cur_soul_point.ToString()).gameObject, "soul_small");

            ride.soul_level = new Vector2((float)p.soulchapter, (float)p.soullevel);
            soul_main = p.soulchapter;
            soul_sub = p.soullevel;
            //GTDebug.LogError("soul_main : " + soul_main.ToString() + "soul_sub: " + soul_sub.ToString());
            if (soul_main == cur_soul_chapter)
            {
                if ((soul_main == 1 && soul_sub == 4) || (soul_main == 2 && soul_sub == 5) || (soul_main >= 3 && soul_sub == 7))
                {
                    GTTools.ChangeSprite(soul.Find("card/" + soul_main.ToString() + "/" + (soul_sub + 1).ToString()).gameObject, "unlock_big");
                    soul.Find("card/" + soul_main.ToString() + "/" + (soul_sub + 1).ToString() + "/select").gameObject.SetActive(true);
                    soul.Find("card/" + soul_main.ToString() + "/" + soul_sub.ToString() + "/select").gameObject.SetActive(false);
                }
                else if ((soul_main == 1 && soul_sub == 5) || (soul_main == 2 && soul_sub == 6) || (soul_main >= 3 && soul_sub == 8))
                {
                    if (soul_main >= 12 && soul_sub == 8)
                    {
                        isclicking = false;

                        //修改坐骑铸魂至满级后，铸魂按钮不会消失的bug

                        nopass.SetActive(false);
                        pass.SetActive(true);
                        gray_button.SetActive(false);

                        
                        return;
                    }
                    else
                    {
                        if (player_level >= unlock_level[soul_main])
                        {
                            Transform temp = soul.Find("left/scroll/grid/" + (soul_main + 1).ToString());
                            SetIconColor(temp, true);
                            AutomaticLoadNextSoulChapter();
                            float fraction = ((float)soul_main + 1) * (1f / 7f) - (3f / 7f);
                            soul.Find("left/scroll").GetComponent<UIScrollView>().SetDragAmount(fraction, 0, false);
                            isclicking = false;
                            return;
                        }
                        soul.Find("card/" + soul_main.ToString() + "/" + soul_sub.ToString() + "/select").gameObject.SetActive(false);
                    }
                    //GTTools.ChangeSprite(soul.Find("card/" + soul_main.ToString() + "/" + (soul_sub + 1).ToString()).gameObject, "unlock_small");
                    
                        
                    
                    
                }

                else
                {
                    GTTools.ChangeSprite(soul.Find("card/" + soul_main.ToString() + "/" + (soul_sub + 1).ToString()).gameObject, "unlock_small");
                    soul.Find("card/" + soul_main.ToString() + "/" + soul_sub.ToString() + "/select").gameObject.SetActive(false);
                    soul.Find("card/" + soul_main.ToString() + "/" + (soul_sub + 1).ToString() + "/select").gameObject.SetActive(true);
                }
            }
            else
            {
                
            }
            cur_soul_chapter = soul_main;
            cur_soul_point = soul_sub + 1;
            if (cur_soul_chapter == 1 && cur_soul_point == 6)
            {
                cur_soul_point = 5;
            }
            else if (cur_soul_chapter == 2 && cur_soul_point == 7)
            {
                cur_soul_point = 6;
            }
            else if (cur_soul_chapter >= 3 && cur_soul_point == 9)
            {
                cur_soul_point = 8;
            }
            LoadSoulCardDescribe();
            LoadSoulSelectEffect(cur_soul_chapter,cur_soul_point);
           
        }
        else
        {
            GTDebug.LogError("RecvRideSoulUnlockReturn not success");
        }
        isclicking = false;
    }

    void LoadUnlockSoulEffect()
    {
        Transform list = soul.Find("card/" + cur_soul_chapter.ToString() + "/" + cur_soul_point.ToString());
        if (effect_soul_unlock == null)
        {
            effect_soul_unlock = soul.Find("zuoqi_yinghun_dianji");
        }
        effect_soul_unlock.gameObject.SetActive(false);
        effect_soul_unlock.gameObject.SetActive(true);
        effect_soul_unlock.parent = list;
        effect_soul_unlock.localPosition = new Vector3(-211.7f, -54.7f);
        effect_soul_unlock.localScale = new Vector3(350, 350, 1);

        Invoke("Turnoffeffect", 0.25f);
        LoadSoulhasunlockedEffect(cur_soul_chapter, cur_soul_point);
    }

    void Turnoffeffect()
    {
        effect_soul_unlock.gameObject.SetActive(false);
    }

    void LoadSoulhasunlockedEffect(int i,int j)
    {
        Transform list = soul.Find("card/" + i.ToString() + "/" + j.ToString());
        Transform temp;
        if (list.Find("select2") == null)
        {
            temp = GTTools.Clone(soul.Find("zuoqi_yinghun_dianliang"), "select2", false).transform;
            temp.gameObject.SetActive(true);
            temp.parent = list;
            temp.localPosition = new Vector3(-0.48f, 0f);
            temp.localScale = new Vector3(350, 350, 1);
        }
    }

    private void SetIconColor(Transform clone, bool p)
    {
        if (p == true)
        {
            clone.Find("icon").GetComponent<UISprite>().color = new Color(1, 1, 1);
            clone.Find("lock").gameObject.SetActive(false);
        }
        else
        {
            clone.Find("icon").GetComponent<UISprite>().color = new Color(0, 0, 0);
            clone.Find("lock").gameObject.SetActive(true);
        }
    }

    //private void LoadTalentData(int level, string petname, int title, int gift_value)
    //{
    //    string sql = "select * from type_mounts_talent where level = {0};";
    //    sql = string.Format(sql, level);
    //    var rr = GTDataBaseManager.GetInstance().Query(sql);

    //    while (rr.Step())
    //    {
    //        var buff1_id = rr.GetInt("buff1");
    //        var buff2_id = rr.GetInt("buff2");
    //        var buff3_id = rr.GetInt("buff3");
    //        var buff4_id = rr.GetInt("buff4");

    //        progress_value.text = player_add_gift_value.ToString() + " / " + rr.GetInt("cost_type").ToString();
    //        SetGiftBar(((float)player_add_gift_value / (float)player_gift_value));

    //    }
    //}

    void OnDragCollider(GTUIEventDispatcher.Event e)
    {
        if (re != null)
        {
            Transform model = re.FindModel("model");
            if (model != null)
            {
                model.localRotation = Quaternion.Euler(0f, -0.3f * e.drag_delta.x, 0f) * model.localRotation;
            }
        }
    }

    void OnClickEnterDetail(GTUIEventDispatcher.Event e)
    {
        DFModelRide.ReadSoulData((int)ride.soul_level.x, (int)ride.soul_level.y,ride.ride_id);
        GTUIManager.OpenWindow(scene, typeof(DFWinRideSub2), "ui/ride/ride_sub", GTWindow.Layer.Window, 0, true, GTUIManager.CoverType.None, null, null);
    }

    /// <summary>
    /// 根据填充百分比设置天赋条
    /// </summary>
    /// <param name="p"></param>
    private void SetGiftBar()
    {
        Transform gift_tree = gift.Find("middle/gift_tree");
        UIPanel panel = gift_tree.GetComponent<UIPanel>();
        float pp = (float)player_add_gift_value / (float)total_gift_cost * 195;
        //GTDebug.LogError(pp.ToString());
        if (pp >= 195)
        {
            pp = 193;
        }
        panel.clipOffset = new Vector2(0, -195+pp);
    }

    void OnDestroy()
    {
        CloseBanner();
    }


    /// <summary>
    /// 关闭窗口时播放自上而下的动画
    /// </summary>
    public override void Close()
    {
        for (int i = 0; i < DFModelRide.ride_List.Count; i++)
        {
            if (ride.gm_id == DFModelRide.ride_List[i].gm_id)
            {
                DFModelRide.ride_List[i] = ride;
            }
        }
        DFWinRide.merit_have = merit_have;
        DFWinRide.player_gift_value = player_gift_value;
        re.Release();
        CloseTweenPositionToBottom(0, 0);
    }

    /// <summary>
    /// 关闭现有货币栏，并打开主界面内货币栏
    /// </summary>
    private void CloseBanner()
    {
        GTUIManager.GetInstance().UnregisterWindowCloseListener<DFWinRideSub>(openWindow);
        DFWinBanner ban = DFWinBanner.GetInstance();
        if (ban != null)
        {
            ban.unregisterWindow(this);
        }
    }
    /// <summary>
    /// 加载坐骑系统货币栏
    /// </summary>
    private void OpenBanner()
    {
        DFWinBanner banner = DFWinBanner.GetInstance();
        if (null != banner)
        {
            banner.PopupWindowFlag = true;
            banner.RegisterReturn(this, false,openWindow);
            banner.SendMessage("HideDropBox", null);
        }
    }

    private void openWindow(GTWindow win)
    {
        if (player_add_gift_value > 0 && isGift == true)
        {
            RideGiftPopUpCallBack rb = rideGiftPopUpCallback2;
            GTUIManager.OpenWindow(scene, typeof(DFWinRideGiftPopUp), "ui/ride/ride_sub_2", GTWindow.Layer.Window, 0, true, GTUIManager.CoverType.None, null, rb);
        }
        else
        {
            if (DFWinBanner.GetInstance().OpenOtherWindowFlag == true)
            {
                DFWinBanner.GetInstance().OpenWindow(DFWinBanner.GetInstance().windowName);
            }
            else
            {
                DFWinBanner.GetInstance().closeLastWindow();
            }
            
            
        }
    }

    private void rideGiftPopUpCallback2(GTWindow win, string button_name)
    {
        if (button_name == "btn_leave")
        {
            if (DFWinBanner.GetInstance().OpenOtherWindowFlag == true)
            {
                DFWinBanner.GetInstance().OpenWindow(DFWinBanner.GetInstance().windowName);
            }
            else
            {
                DFWinBanner.GetInstance().closeLastWindow();
            }
            //DFWinBanner.GetInstance().closeLastWindow();
            return;
        }
        else if (button_name == "btn_continue")
        {
            win.CloseTweenAlpha();
            return;
        }
    }
}