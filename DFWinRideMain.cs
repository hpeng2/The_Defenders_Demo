using System.Collections.Generic;
using UnityEngine;

public class DFWinRide : GTWindow
{
    DFModelRide m_model;
    DFModelPlayer m_model_player;

    public static bool TAB_GIFT = false;
    public static DFModelRide.Ride Ride;

    Transform list;
    Transform main;
    Transform des;
    Transform main_list;
    Transform list_list;

    GameObject btn_cl;
    GameObject btn_qxcl;
    GameObject btn_qc;
    GameObject btn_qxqc, btn_unlock;
    GameObject lockLabel;

    int last_index, index, index_id;//选中坐骑index
    int current_select_ride_id;//选中坐骑id
    public static int merit_have; //玩家功勋值
    int avaliable_socket;//以解锁槽位数量
    public static int player_gift_value;

    int IsCurrentState = -1; //当前状态;
    bool Ischange = false; //坐骑状态是否改变;

    //List<DFModelRide.Ride> DFModelRide.ride_List = new List<DFModelRide.Ride>();
    List<DFModelRide.Ride> swapped_attend_list;//加载排列战力后的坐骑列表
    public static RenderTextureCreator re = null;

    List<int> lock_list; //骑士团列表解锁等级列表
   //List<int> level_list; // 骑士团坐骑等级解锁列表
    //int[] attend_list; //骑士团列表坐骑参列id列表
    public static int player_level; //玩家等级
    int fightvalue; //缓存玩家战力
    int attend_position;//参战位置



    UILabel t1, t2, t3, t4, t5, t6, t7, t8, v1, v2, v3, v4, v5, v6, v7, v8;

    void Awake()
    {

    }
    void Start()
    {
        IsCurrentState = DFModelRide.Ride_ID;
        list = transform.Find("index/list");
        main = transform.Find("index/main");
        des = transform.Find("index/des");
        main_list = main.Find("list/grid");
        list_list = list.Find("grid");

        btn_cl = main.Find("detail/btn_cl").gameObject; //参列按钮
        btn_qxcl = main.Find("detail/btn_qxcl").gameObject; // 取消参列按钮
        btn_qc = main.Find("detail/btn_qc").gameObject; // 骑乘按钮
        btn_qxqc = main.Find("detail/btn_qxqc").gameObject; // 取消骑乘按钮
        btn_unlock = main.Find("detail/lock/btn_unlock").gameObject;
        //btn_unlock_lvl = main.Find("detail/lock/btn_unlock_level").gameObject;
        lockLabel = main.Find("detail/lock/lock_text").gameObject;

        t1 = des.Find("tohero/1/t").GetComponent<UILabel>();
        t2 = des.Find("tohero/2/t").GetComponent<UILabel>();
        t3 = des.Find("tohero/3/t").GetComponent<UILabel>();
        t4 = des.Find("tohero/4/t").GetComponent<UILabel>();
        t5 = des.Find("tohero/5/t").GetComponent<UILabel>();
        t6 = des.Find("tohero/6/t").GetComponent<UILabel>();
        t7 = des.Find("topet/1/t").GetComponent<UILabel>();
        t8 = des.Find("topet/2/t").GetComponent<UILabel>();
        //t9 = des.Find("topet/2/t").GetComponent<UILabel>();

        v1 = des.Find("tohero/1/v").GetComponent<UILabel>();
        v2 = des.Find("tohero/2/v").GetComponent<UILabel>();
        v3 = des.Find("tohero/3/v").GetComponent<UILabel>();
        v4 = des.Find("tohero/4/v").GetComponent<UILabel>();
        v5 = des.Find("tohero/5/v").GetComponent<UILabel>();
        v6 = des.Find("tohero/6/v").GetComponent<UILabel>();
        v7 = des.Find("topet/1/v").GetComponent<UILabel>();
        v8 = des.Find("topet/2/v").GetComponent<UILabel>();
        //v9 = des.Find("topet/2/v").GetComponent<UILabel>();

        UITexture texture2 = main.Find("detail/model").GetComponent<UITexture>();
        re = RenderTextureCreator.create(texture2.gameObject, 250, 250);
        texture2.uvRect = new Rect(0, 0, 1, 1);
        texture2.gameObject.AddComponent<GTUIEventDispatcher>().onDrag = "OnDragCollider";
        texture2.gameObject.AddComponent<BoxCollider>().size = texture2.localSize;
        
        m_model = GTDataModelManager.GetInstance().GetModel(DFModelType.DFModelRide) as DFModelRide;
        m_model.AddView("RecvRideDataReturn", gameObject);
        m_model.AddView("RecvRideAttendReturn", gameObject);
        m_model.AddView("RecvRideNotAttendReturn", gameObject);
        m_model.AddView("RecvRideOneKeyUpReturn", gameObject);
        m_model.AddView("RecvRideRideReturn", gameObject);
        m_model.AddView("RecvRideUnlockReturn", gameObject);
        m_model.AddView("RecvRideSoulUnlockReturn", gameObject);
        m_model.AddView("UpdateRideList", gameObject);
        m_model.AddView("RecvRideFightInfoChg", gameObject);

        m_model_player = GTDataModelManager.GetInstance().GetModel<DFModelPlayer>(DFModelType.DFModelPlayer) as DFModelPlayer;
        m_model_player.AddView("RecvPlayerInfo", gameObject);
        m_model_player.AddView("RecvPlayerChgInfo", gameObject);
        m_model_player.UpdateModel("PlayerInfoGet", null);


        fightvalue = -1;
        last_index = -1; //表示没有
        avaliable_socket = 0;
        //merit_have = 50000;

        GTUIEventDispatcher.SetAllEventTargetToWindow(this);
        OpenTweenPositionFromBottom(0, 0);
        OpenBanner();

    }
    void RecvPlayerChgInfo(DFModelPlayer.PlayerInfo info)
    {
        //if (fightvalue != -1)
        //{
        //    PopupText.GetInstance().SaveData(fightvalue, info.fightvalue);
        //}
        fightvalue = info.fightvalue;
        player_level = info.fightlevel;
        if (player_level == 40)
        {
            
        }
        merit_have = info.exploit;
        player_gift_value = Bag_Info.GetInstance().getItemCountInBag(1550210009);
        SetSoulAndGiftUnlockIcon();
    }
    void RecvPlayerInfo(DFModelPlayer.PlayerInfo info)
    {
        RecvPlayerChgInfo(info);
        m_model.UpdateModel("SendRideDataRequest", null);
        
    }
    void LoadList()
    {
        //设置解锁
        for (int i = 0; i < lock_list.Count; i++)
        {
            if (player_level < lock_list[i])
            {
                list.Find("grid/" + (i + 1).ToString() + "/lock/text").GetComponent<UILabel>().text = lock_list[i].ToString() + Localization.Get("ride leveltounlock");
                list.Find("grid/" + (i + 1).ToString() + "/lock").gameObject.SetActive(true);
            }
            else
            {
                avaliable_socket++;
                list.Find("grid/" + (i + 1).ToString() + "/lock").gameObject.SetActive(false);
            }
        }
        //设置以上阵坐骑
        for (int i = 0; i < DFModelRide.ride_List.Count; i++)
        {
            int attend_pos = DFModelRide.ride_List[i].attend_pos;
            if (attend_pos != 0)
            {
                Transform icon = list_list.Find(attend_pos.ToString() + "/icon");
                FunctionClass.ChangeTexture(icon, (DFModelRide.ride_List[i].ride_id).ToString() + ".png");
                icon.GetComponent<UITexture>().alpha = 1;
            }


        }
    }

    /// <summary>
    /// 加载主界面坐骑列表
    /// </summary>
    void LoadMainList()
    {
        Transform entry = main_list.Find("a");
        for (int i = 0; i < DFModelRide.ride_List.Count; i++)
        {
            Transform clone_entry = GTTools.Clone(entry, i.ToString(), false).transform;

            //加载坐骑图像
            Transform ridepic = clone_entry.Find("ridepic");
            FunctionClass.ChangeTexture(ridepic, DFModelRide.ride_List[i].pic_id.ToString() + ".png");

            //加载坐骑名字
            GTTools.ChangeLabeText(clone_entry, "name", DFModelRide.ride_List[i].ride_name);

            if (DFModelRide.ride_List[i].is_unlock == false)
            {
                SetIconDisable(clone_entry, true);
            }

            //左右排列
            if (i % 2 == 1)
            {
                ridepic.localPosition = new Vector3(-57, 0);
                clone_entry.Find("name").localPosition = new Vector3(44, 0);
            }
        }
        main_list.GetComponent<UIGrid>().repositionNow = true;
        UpdateRedPoint();
    }
    void ShowModel(int index_num)
    {
        index = index_num;
        UpdateRedPoint();
        //index = int.Parse(e.sender.name);
        index_id = DFModelRide.ride_List[index].ride_id;
        Ride = DFModelRide.ride_List[index];
        attend_position = DFModelRide.ride_List[index].attend_pos;

        if (Ride.is_ride == true)
        {
            main.Find("detail/ridding").gameObject.SetActive(true);
        }
        else
        {
            main.Find("detail/ridding").gameObject.SetActive(false);
        }

        //第一次选中或者改变条目
        if (last_index != index)
        {
            Transform current_entry = main_list.Find(index.ToString());

            //根据条件改变骑乘与参列按钮
            if (DFModelRide.ride_List[index].is_ride == true)
            {
                btn_qc.SetActive(false);
                btn_qxqc.SetActive(true);
            }
            else
            {
                btn_qc.SetActive(true);
                btn_qxqc.SetActive(false);
            }
            if (DFModelRide.ride_List[index].attend_pos != 0)
            {
                btn_cl.SetActive(false);
                btn_qxcl.SetActive(true);
            }
            else
            {
                btn_cl.SetActive(true);
                btn_qxcl.SetActive(false);
            }

            //选中条目
            Transform bg = current_entry.Find("bg");
            GTTools.ChangeSprite(bg.gameObject, "win_light_yellow");
            current_entry.Find("arrow").gameObject.SetActive(true);
            UILabel ride_name = current_entry.Find("name").GetComponent<UILabel>();
            ride_name.color = new Color(255 / 255f, 208 / 255f, 132 / 255f);

            //加载坐骑锁
            bool isUnlock = DFModelRide.ride_List[index].is_unlock;
            if (isUnlock == false)
            {
                main.Find("detail/lock").gameObject.SetActive(true);

                if (player_level < Ride.unlock_level)
                {
                    lockLabel.GetComponent<UILabel>().text = Ride.unlock_level.ToString() + Localization.Get("ride level") + " " + Localization.Get("ride unlock");
                    lockLabel.SetActive(true);
                    
                }
                else
                {
                    lockLabel.SetActive(false);
                }

                //加载坐骑锁内所需功勋
                int merit_need = DFModelRide.ride_List[index].unlock_merit;
                UILabel merit_label = main.Find("detail/lock/lock_label/v").GetComponent<UILabel>();
                if (!GTTools.isNullAndReport(merit_label))
                {
                    merit_label.text = merit_need.ToString();
                }

                btn_cl.SetActive(false);
                btn_qc.SetActive(false);
                btn_qxcl.SetActive(false);
                btn_qxqc.SetActive(false);

            }
            else
            {
                main.Find("detail/lock").gameObject.SetActive(false);
            }

            //加载坐骑模型
            re.DelModels();
            current_select_ride_id = (int)DFModelRide.ride_List[index].ride_id;
            Character.getBody(current_select_ride_id, GetBodyCallBack);

            //如果不是第一次点击坐骑条目，还原条目bg
            if (last_index != -1)
            {

                Transform last_entry = main_list.Find(last_index.ToString());
                Transform bg1 = last_entry.Find("bg");

                GTTools.ChangeSprite(bg1.gameObject, "win_light");
                last_entry.Find("arrow").gameObject.SetActive(false);

                UILabel rid_name = last_entry.Find("name").GetComponent<UILabel>();
                rid_name.color = new Color(255 / 255f, 237 / 255f, 207 / 255f);
            }
        }
        last_index = index;
    }
    void OnClickShowModel(GTUIEventDispatcher.Event e)
    {   
        int index = int.Parse(e.sender.name);
        ShowModel(index);
    }

    void LoadDefaultModel()
    {
        if (DFModelRide.Ride_Index != -1)
        {
            index = DFModelRide.Ride_Index;
        }
        else
        {
            index = 0;
        }
        ShowModel(index);
    }

    void UpdateRideList(PBMessage.GM_HorseNotifyInt32 p)
    {
    }
    void RecvRideDataReturn(PBMessage.GM_HorseInfoList p)
    {
        //DFModelRide.ride_List = DFModelRide.ride_List;
        lock_list = DFModelRide.Lock_List;
        //load des title
        des.Find("title").GetComponent<UILabel>().text = Localization.Get("ride maindestitle");
        des.Find("tohero").GetComponent<UILabel>().text = Localization.Get("ride maindestohero");
        des.Find("topet").GetComponent<UILabel>().text = Localization.Get("ride maindestopet");
        //
        LoadList(); //加载骑士团列表
        LoadMainList(); //加载坐骑列表
        LoadMainBuffDescirbe();
        LoadDefaultModel();
        LoadComplete();
    }

    /// <summary>
    /// 玩家点击解锁坐骑按钮
    /// </summary>
    /// <param name="e"></param>
    void OnClickUnlock(GTUIEventDispatcher.Event e)
    {
        //检查等级
        if (player_level < DFModelRide.ride_List[index].unlock_level)
        {
            string str = string.Format(Localization.Get("ride levelnotenoughtounlock"),DFModelRide.ride_List[index].unlock_level.ToString());
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + str, GTUIManager.DialogType.AutoClose, null);
            return;
        }

        int merit_need = DFModelRide.ride_List[index].unlock_merit;
        if (merit_have < merit_need)
        {
            //弹窗 功勋值不足
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride unabletounlock"), GTUIManager.DialogType.AutoClose, null);
        }
        else
        {
            //弹窗 确认按钮
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride unlock1") + merit_need.ToString() + Localization.Get("ride unlock2"), GTUIManager.DialogType.OKCancel, SetConfirm);
        }
    }

    void SetConfirm(GTWindow win, GTUIManager.DialogButton button)
    {
        switch (button)
        {
            case GTUIManager.DialogButton.Cancel:
                break;
            case GTUIManager.DialogButton.OK:
                PBMessage.GM_HorseUnlock rr = new PBMessage.GM_HorseUnlock();
                rr.horseid = index_id;
                m_model.UpdateModel("SendRideUnlockRequest", rr);
                break;

        }
    }

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

    void RecvRideUnlockReturn(PBMessage.GM_HorseUnlockReturn p)
    {
        if (p.m_result == 0)
        {
            main.Find("detail/lock").gameObject.SetActive(false);
            btn_cl.SetActive(true);
            btn_qc.SetActive(true);
            SetIconDisable(main_list.Find(index.ToString()), false);
            DFModelRide.ride_List[index].is_unlock = true;
            UpdateRedPoint();
        }
        else
        {
            GTDebug.LogError("RecvRideUnlockReturn not success!");
        }
    }

    void OnClickJoin(GTUIEventDispatcher.Event e)
    {
        PBMessage.GM_HorseUpCampRequest rr = new PBMessage.GM_HorseUpCampRequest();
        rr.gmid = DFModelRide.ride_List[index].gm_id;
        m_model.UpdateModel("SendRideAttendRequest", rr);
    }

    void RecvRideAttendReturn(PBMessage.GM_HorseUpCampReturn p)
    {
        if (p.m_result == 0) //成功更变坐骑
        {
            Transform temp = list_list.Find(p.pos.ToString());
            FunctionClass.ChangeTexture(temp.Find("icon"), DFModelRide.ride_List[index].ride_id.ToString() + ".png");
            temp.Find("icon").GetComponent<UITexture>().alpha = 1;
            DFModelRide.ride_List[index].attend_pos = p.pos; //更新缓存
            DFModelRide.num_already_join++;

            btn_cl.SetActive(false);
            btn_qxcl.SetActive(true);
        }
        else
        {
            GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride listfull"), GTUIManager.DialogType.AutoClose, null);
        }
    }


    void OnClickNotJoin(GTUIEventDispatcher.Event e)
    {
        PBMessage.GM_HorseDownCampRequest rr = new PBMessage.GM_HorseDownCampRequest();
        rr.gmid = DFModelRide.ride_List[index].gm_id;
        m_model.UpdateModel("SendRideNotAttendRequest", rr);
    }

    void RecvRideNotAttendReturn(PBMessage.GM_HorseDownCampReturn p)
    {
        if (p.m_result == 0)
        {
            //GTDebug.LogError("attend_pos:: " + attend_position.ToString());
            for (int i = 0; i < p.posinfo.Count; i++)
            {
                for (int j = 0; j < DFModelRide.ride_List.Count; j++)
                {
                    if (p.posinfo[i].gmid == DFModelRide.ride_List[j].gm_id)
                    {
                        DFModelRide.ride_List[j].attend_pos = p.posinfo[i].nvalue;
                        if(p.posinfo[i].nvalue != 0){
                            Transform temp = list_list.Find(p.posinfo[i].nvalue.ToString());
                            FunctionClass.ChangeTexture(temp.Find("icon"), DFModelRide.ride_List[j].ride_id.ToString() + ".png");
                            temp.Find("icon").GetComponent<UITexture>().alpha = 1;
                        }
                    }
                }
            }
            //GTDebug.LogError("socket: " + DFModelRide.num_already_join.ToString());
            Transform temp1 = list_list.Find(DFModelRide.num_already_join.ToString());
            temp1.Find("icon").GetComponent<UITexture>().alpha = 0;
            DFModelRide.num_already_join--;
            
            btn_qxcl.SetActive(false);
            btn_cl.SetActive(true);
        }
        else if (p.m_result == 1)
        {
            GTDebug.LogError("RecvRideNotAttendReturn not success");
        }
    }
    void OnClickAllJoin(GTUIEventDispatcher.Event e)
    {
        PBMessage.GM_HorseOneKeyUpRequest rr = new PBMessage.GM_HorseOneKeyUpRequest();
        swapped_attend_list = m_model.ReturnTopFightRide(DFModelRide.ride_List);
        int length;
        if (avaliable_socket > swapped_attend_list.Count)
        {
            length = swapped_attend_list.Count;
        }
        else
        {
            length = avaliable_socket;
        }
        for (int i = 0; i < length; i++)
        {
            //GTDebug.LogError("fight rank ...............");
            //GTDebug.LogError(swapped_attend_list[i].fightvalue.ToString());
            rr.gmid.Add(swapped_attend_list[i].gm_id);
        }
        m_model.UpdateModel("SendOneKeyUpRequest", rr);
    }

    void RecvRideOneKeyUpReturn(PBMessage.GM_HorseOneKeyUpReturn p)
    {
        if (p.m_result == 0)
        {
            int length;
            if (avaliable_socket > swapped_attend_list.Count)
            {
                length = swapped_attend_list.Count;
            }
            else
            {
                length = avaliable_socket;
            }
            for (int i = 0; i < length; i++)
            {
                DFModelRide.num_already_join = length;
                Transform icon = list_list.Find((i + 1).ToString() + "/icon");
                FunctionClass.ChangeTexture(icon, swapped_attend_list[i].ride_id.ToString() + ".png");
                icon.GetComponent<UITexture>().alpha = 1;
                //DFModelRide.attend_ride_list[swapped_attend_list[i].ride_id] = swapped_attend_list[i].attend_pos;
            }

            for (int i = 0; i < p.posinfo.Count; i++)
            {
                for (int j = 0; j < p.posinfo.Count; j++){
                    if (p.posinfo[i].gmid == DFModelRide.ride_List[j].gm_id)
                    {
                        DFModelRide.ride_List[j].attend_pos = p.posinfo[i].nvalue;
                    }
                }
                
            }

            if (DFModelRide.ride_List[index].attend_pos != 0)
            {
                btn_cl.SetActive(false);
                btn_qxcl.SetActive(true);
            }
            else
            {
                btn_cl.SetActive(true);
                btn_qxcl.SetActive(false);
            }
        }
        else
        {
            GTDebug.LogError("RecvRideOneKeyUpReturn not success!");
        }
    }

    void OnClickSetRide(GTUIEventDispatcher.Event e)
    {
        PBMessage.GM_HorseFight rr = new PBMessage.GM_HorseFight();
        rr.gmid = DFModelRide.ride_List[index].gm_id;
        rr.type = 1;
        m_model.UpdateModel("SendRideRideRequest", rr);

        //DFModelRide.Ride_ID = current_select_ride_id;
        //Debug.LogError(DFModelRide.Ride_ID.ToString());
    }

    void OnClickNotSetRide(GTUIEventDispatcher.Event e)
    {
        PBMessage.GM_HorseFight rr = new PBMessage.GM_HorseFight();
        rr.gmid = DFModelRide.ride_List[index].gm_id;
        rr.type = 2;
        m_model.UpdateModel("SendRideRideRequest", rr);
    }

    void RecvRideRideReturn(PBMessage.GM_HorseFightReturn p)
    {
        if (p.result == 0)
        {

            if (IsCurrentState == DFModelRide.isfightid)
            {
                Ischange = false;
            }
            else 
            {
                Ischange = true;
            }

            if (p.type == 1) //骑乘
            {
                for (int i = 0; i < DFModelRide.ride_List.Count; i++)
                {
                    if (DFModelRide.ride_List[i].is_ride == true)
                    {
                        DFModelRide.ride_List[i].is_ride = false;
                        break;
                    }
                    
                }
                DFModelRide.ride_List[index].is_ride = true;
                main.Find("detail/ridding").gameObject.SetActive(true);
                DFModelRide.isfightid = DFModelRide.ride_List[index].ride_id;
                DFModelRide.Ride_Index = index;
                //DFModelRide.Ride_ID = DFModelRide.ride_List[index].ride_id;
                btn_qxqc.SetActive(true);
                btn_qc.SetActive(false);
                GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride setridesuccess"), GTUIManager.DialogType.AutoClose, null);
            }
            else if (p.type == 2)//取消骑乘
            {
                main.Find("detail/ridding").gameObject.SetActive(false);
                DFModelRide.ride_List[index].is_ride = false;
                DFModelRide.Ride_Index = -1;
                btn_qxqc.SetActive(false);
                btn_qc.SetActive(true);
                GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride setnotridesuccess"), GTUIManager.DialogType.AutoClose, null);
            }
        }
        else
        {
            GTDebug.LogError("RecvRideRideReturn not success!");
        }
    }

    void GetBodyCallBack(GameObject o)
    {
        if (o != null)
        {
            if (re != null)
            {
                re.AddModel(o, "model", new Vector3(0F, -0.84f, 4F), new Vector3(0, 150, 0));
            }
        }

    }

    void RecvRideFightInfoChg(PBMessage.GM_HorseAddFightChange p)
    {
        //GTDebug.LogError("updating main screen list");
        LoadMainBuffDescirbe();

    }

    public void UpdateRedPoint()
    {
        for (int i = 0; i < DFModelRide.ride_List.Count; i++)
        {
            bool setture = false;
            bool on_next_chapter = false;
            DFModelRide.Ride temp = DFModelRide.ride_List[i];
            if (temp.is_unlock == false && merit_have >= temp.unlock_merit && player_level >= temp.unlock_level)
            {
                setture = true;
            }

            int soul_chapter = (int)temp.soul_level.x;
            int soul_point = (int)temp.soul_level.y;

            if ((soul_chapter == 1 && soul_point == 5) || (soul_chapter == 2 && soul_point == 6) || (soul_chapter >= 3 && soul_point == 8) && (soul_point != 12 && soul_point == 8))
            {
                on_next_chapter = true;
            }
            if (temp.is_unlock == true && merit_have >= DFModelRide.GetMeritNeedToUnlockSoul(soul_chapter, soul_point))
            {
                if (on_next_chapter)
                {
                    if (player_level >= DFModelRide.soul_unlock_level_list[soul_chapter])
                    {
                        setture = true;
                    }
                }
                else
                {
                    setture = true;
                }
            }
            if (main_list == null)
            {
                return;
            }
            if (setture)
            {
                main_list.Find(i.ToString() + "/red").gameObject.SetActive(true);
            }
            else
            {
                main_list.Find(i.ToString() + "/red").gameObject.SetActive(false);
            }
        }
        UpdateRedPointSoulAndGift();
    }

    bool UpdateRedPointSoulAndGift()
    {
        if (main == null)
        {
            return false;
        }
        bool result = false;
        bool on_next_chapter = false;
        DFModelRide.Ride temp = DFModelRide.ride_List[index];
        if (player_level == 40 && temp.is_unlock == true)
        {
            main.Find("detail/btn_gift/red").gameObject.SetActive(true);
            result = true;
        }
        else
        {
            main.Find("detail/btn_gift/red").gameObject.SetActive(false);
        }

        int soul_chapter = (int)temp.soul_level.x;
        int soul_point = (int)temp.soul_level.y;

        if ((soul_chapter == 1 && soul_point == 5) || (soul_chapter == 2 && soul_point == 6) || (soul_chapter >= 3 && soul_point == 8) && (soul_point != 12 && soul_point == 8))
        {
            on_next_chapter = true;
        }
        if (temp.is_unlock == true && merit_have >= DFModelRide.GetMeritNeedToUnlockSoul(soul_chapter, soul_point))
        {
            if (on_next_chapter)
            {
                if (player_level >= DFModelRide.soul_unlock_level_list[soul_chapter])
                {
                    main.Find("detail/btn_soul/red").gameObject.SetActive(true);
                    result = true;
                }
                else
                {
                    main.Find("detail/btn_soul/red").gameObject.SetActive(false);
                }
            }
            else
            {
                main.Find("detail/btn_soul/red").gameObject.SetActive(true);
                result = true;
            }
        }
        else
        {
            main.Find("detail/btn_soul/red").gameObject.SetActive(false);
        }

        return result;
    }

    

    private void LoadMainBuffDescirbe()
    {
        Dictionary<int, int> buff_value = DFModelRide.buff_value_list;
        Dictionary<int, string> buff_title = DFModelRide.buff_title_list;

        UILabel[] titles = { t1, t2, t3, t4, t5, t6, t7, t8 };
        UILabel[] values = { v1, v2, v3, v4, v5, v6, v7, v8 };

        int temp;

        t1.text = buff_title[5];
        t2.text = buff_title[6];
        t3.text = buff_title[7];
        t4.text = buff_title[8];
        t5.text = buff_title[9];
        t6.text = buff_title[10];
        t7.text = buff_title[11];
        t8.text = buff_title[12];
        v1.text = "+" + (buff_value[1] + buff_value[5]).ToString();
        v2.text = "+" + (buff_value[2] + buff_value[6]).ToString();
        v3.text = "+" + (buff_value[3] + buff_value[7]).ToString();
        v4.text = "+" + (buff_value[4] + buff_value[8]).ToString();
        temp = buff_value[9] / 100;
        v5.text = "+" + temp.ToString()+"%";
        temp = buff_value[10] / 100;
        v6.text = "+" + temp.ToString() + "%";
        temp = buff_value[11] / 100;
        v7.text = "+" + temp.ToString() + "%";
        temp = buff_value[12] / 100;
        v8.text = "+" + temp.ToString() + "%";
    }

    void RecvRideSoulUnlockReturn(PBMessage.GM_HorseSoulUnlockReturn p)
    {
        DFModelRide.ride_List[index].soul_level = new Vector2(p.soulchapter, p.soullevel);
        DFModelRide.ride_List[index].soul_level = new Vector2(p.soulchapter, p.soullevel);
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
        CloseTweenPositionToBottom(0, 0);

        //DFModelDrama drama = GTDataModelManager.GetInstance().GetModel(DFModelType.DFModelDrama) as DFModelDrama;
        NewGuidelines guideType = GTDataModelManager.GetInstance().GetModel<DFModelGuide>(DFModelType.DFModelGuide).nowGuideType;
        if (guideType == NewGuidelines.NG_Ride || guideType == NewGuidelines.NG_Ride1 || guideType == NewGuidelines.NG_Ride2) 
        {
            return;
        }

        if (Ischange)
        {
            if (DFModelRide.isfightid == 0)
            {
                m_model.Request_Horse_down();
            }
            else
            {
                if (DFModelRide.is_onride)
                {
                    m_model.Request_Change_Ride();
                }
                else
                {
                    m_model.Request_Horse_Ride();
                }

            }

        }
        
    }

    /// <summary>
    /// 关闭现有货币栏，并打开主界面内货币栏
    /// </summary>
    private void CloseBanner()
    {
        DFWinBanner ban = DFWinBanner.GetInstance();
        GTUIManager.GetInstance().UnregisterWindowCloseListener<DFWinRide>(UpdateRedPointInfo);
        if (ban != null)
        {
            ban.restoreLastCurrency();
            ban.unregisterWindow(this);
        }
        DFWinBanner.GetInstance().unregisterWindow(this);
    }
    /// <summary>
    /// 加载坐骑系统货币栏
    /// </summary>
    private void OpenBanner()
    {
        DFWinBanner banner = DFWinBanner.GetInstance();
        if (null != banner)
        {
            banner.RegisterReturn(this, false,UpdateCallBack);
            banner.SendMessage("HideDropBox", null);
        }
    }

    protected override void OnOpenAnimFinished()
    {
        base.OnOpenAnimFinished();
        DFWinBanner banner = DFWinBanner.GetInstance();
        banner.showOtherCurrency(DFWinBanner.ShowCurrency.gold, DFWinBanner.ShowCurrency.diamond, DFWinBanner.ShowCurrency.merit);
    }

    void UpdateCallBack(GTWindow win)
    {
        m_model.CheckMainRedPoint();
        DFWinBanner.GetInstance().closeLastWindow();
    }
    /// <summary>
    /// 设置坐骑列表的锁定状态
    /// </summary>
    /// <param name="entry"> 该条目的Transform</param>
    private void SetIconDisable(Transform entry, bool isDisable)
    {
        Transform texture = entry.Find("ridepic");
        UITexture pic = texture.GetComponent<UITexture>();
        Transform name = entry.Find("name");
        Transform lock_label = entry.Find("lock");

        if (isDisable)
        {
            pic.height = 64;
            pic.uvRect = new Rect(0, 0.07f, 1, 0.76f);
            pic.color = new Color(165 / 255f, 174 / 255f, 184 / 255f, 175 / 255f);
            name.gameObject.SetActive(false);
            lock_label.gameObject.SetActive(true);
        }
        else
        {
            pic.MakePixelPerfect();
            pic.uvRect = new Rect(0, 0, 1, 1);
            pic.color = new Color(255 / 255f, 255 / 255f, 255 / 255f, 255 / 255f);
            name.gameObject.SetActive(true);
            lock_label.gameObject.SetActive(false);
        }
    }

    private void SetSoulAndGiftUnlockIcon()
    {
        Transform soul_btn = main.Find("detail/btn_soul");
        Transform gift_btn = main.Find("detail/btn_gift");

        if (player_level < m_model.soul_unlock_level)
        {
            soul_btn.Find("lock").gameObject.SetActive(true);
            soul_btn.Find("pic").GetComponent<UISprite>().color = new Color(0, 0, 0);
        }
        if (player_level < m_model.gift_unlock_level)
        {
            gift_btn.Find("lock").gameObject.SetActive(true);
            GTTools.ChangeSprite(gift_btn.Find("pic").gameObject, "gift_lock");
            //gift_btn.Find("pic").GetComponent<UISprite>().color = new Color(0, 0, 0);
        }
 
    }

    void UpdateRedPointInfo(GTWindow win){
        UpdateRedPoint();
    }

    private void OnClickEnterSub(GTUIEventDispatcher.Event e)
    {
        //GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride cannotpass"), GTUIManager.DialogType.AutoClose, null);
        GTUIManager.GetInstance().RegisterWindowCloseListener<DFWinRideSub>(UpdateRedPointInfo);

        if (e.sender.name == "btn_gift")
        {
            if (player_level < m_model.gift_unlock_level)
            {
                GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride nopassgiftenter"), GTUIManager.DialogType.AutoClose, null);
            }
            else
            {
                TAB_GIFT = true;
                main.Find("detail/btn_gift/red").gameObject.SetActive(false);
                GTUIManager.OpenWindowWithCoverBlur(scene, typeof(DFWinRideSub), "ui/ride/ride", null);
            }
            
        }
        else if (e.sender.name == "btn_soul")
        {
            if (player_level < m_model.soul_unlock_level)
            {
                GTUIManager.OpenDialogWithText(scene, "[FFEDCF]" + Localization.Get("ride nopasssoulenter"), GTUIManager.DialogType.AutoClose, null);
            }
            else
            {
                TAB_GIFT = false;
                GTUIManager.OpenWindowWithCoverBlur(scene, typeof(DFWinRideSub), "ui/ride/ride", null);
            }
        }
        else
        {
            GTDebug.LogError("Wrong button input infomation!");
            return;
        }
        

    }
        
    /// <summary>
    /// 加载骑士团加持buff 字段
    /// </summary>
    /// <param name="title">属性名</param>
    /// <param name="value">数值</param>
    /// <param name="who">0：人物，1：宠物</param>
    /// <param name="pos">条目位置 1-4</param>
    void SetDescribeString(string title, string value, int who, int pos)
    {
        if (who == 0)
        {
            UILabel label = des.Find("tohero/" + pos.ToString() + "/" + "t").GetComponent<UILabel>();
            UILabel label1 = des.Find("tohero/" + pos.ToString() + "/" + "v").GetComponent<UILabel>();

            if (label != null && label1 != null)
            {
                label.text = title;
                label1.text = value;
            }
        }
        else
        {
            UILabel label = des.Find("topet/" + pos.ToString() + "/" + "t").GetComponent<UILabel>();
            UILabel label1 = des.Find("topet/" + pos.ToString() + "/" + "v").GetComponent<UILabel>();

            if (label != null && label1 != null)
            {
                label.text = title;
                label1.text = value;
            }
        }
    }
}