// ignore_for_file: non_constant_identifier_names
// /***************************************************************************/
// /**************************** CLASS ****************************************/
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

var class_name_selected_language = 'Please select language';
// /***************************************************************************/
// /**************************** MENU BAR *************************************/
var menu_bar_dashboard_en = 'Dashboard';
var menu_bar_dashboard_sp = 'panel';
// edit profile
var menu_bar_edit_profile_en = 'Edit Profile';
var menu_bar_edit_profile_sp = 'Editar perfil';
// q/a
var menu_bar_q_a_en = 'Q/A';
var menu_bar_q_a_sp = 'Q/A';
// order history
var menu_bar_order_hostry_en = 'Order History';
var menu_bar_order_hostry_sp = 'Historial de pedidos';
// help
var menu_bar_help_en = 'Help';
var menu_bar_help_sp = 'Ayuda';
// change password
var menu_bar_change_password_en = 'Change Password';
var menu_bar_change_password_sp = 'Cambiar la contraseña';
// language
var menu_bar_language_en = 'Language';
var menu_bar_language_sp = 'Idioma';
// settings
var menu_bar_settings_en = 'Settings';
var menu_bar_settings_sp = 'Ajustes';
// logout
var menu_bar_logout_en = 'Logout';
var menu_bar_logout_sp = 'Cerrar sesión';
// /***************************************************************************/
// /**************************** HOME *****************************************/
// goals
var dashboard_goal_en = 'Goals';
var dashboard_goal_sp = 'Objetivos';
// subgoals
var dashboard_sub_goals_en = 'Sub - Goals';
var dashboard_sub_goals_sp = 'Sub-Goles';
// lquest
var dashboard_quest_en = 'Quest';
var dashboard_quest_sp = 'Búsqueda';
// mission
var dashboard_mission_en = 'Missions';
var dashboard_mission_sp = 'Misiones';
// task
var dashboard_task_en = 'Tasks';
var dashboard_task_sp = 'Tareas';
// training
var dashboard_training_en = 'Training';
var dashboard_training_sp = 'Capacitación';
// grinds
var dashboard_grinds_en = 'Grinds';
var dashboard_grinds_sp = 'Muele';
// habits
var dashboard_habits_en = 'Habits';
var dashboard_habits_sp = 'Hábitos';
// quotes
var dashboard_quotes_en = 'Quotes';
var dashboard_quotes_sp = 'Citas';
// skills
var dashboard_skills_en = 'Skills';
var dashboard_skills_sp = 'Habilidades';
// friends
var dashboard_friends_en = 'Friends';
var dashboard_friends_sp = 'Amigos';
// request
var dashboard_requests_en = 'Requests';
var dashboard_requests_sp = 'Peticiones';
// notes
var dashboard_notes_en = 'Notes';
var dashboard_notes_sp = 'Notas';
// inventory
var dashboard_inventory_en = 'Inventory';
var dashboard_inventory_sp = 'Inventario';
// shops
var dashboard_shops_en = 'Shops';
var dashboard_shops_sp = 'Tiendas';
// actions
var dashboard_actions_en = 'Actions';
var dashboard_actions_sp = 'Peticiones';
// guilds
var dashboard_guilds_en = 'Guilds';
var dashboard_guilds_sp = 'Gremios';
// /***************************************************************************/
// /**************************** ALERT ****************************************/
var select_language_alert_text = 'Selected language Alert';
var select_language_alert_en = 'Selected language : English';
var select_language_alert_sp = 'Idioma seleccionado : Español';
// /***************************************************************************/
// /**************************** SELECT LANGUAGE ******************************/
var select_language_text = 'Please select language';
var select_language_en = 'Please select language';
var select_language_sp = 'Por favor seleccione idioma';
// /***************************************************************************/
// /**************************** HABITS ***************************************/
////////////////////////////////////////////////////////////////////////////////
var habit_you_already_update_status_EN =
    "You have already updated your today's status";
////////////////////////////////////////////////////////////////////////////////
var habits_info_EN = 'Habits Info';
////////////////////////////////////////////////////////////////////////////////
var habits_create_new_habits_EN = 'Create new habit';
////////////////////////////////////////////////////////////////////////////////
// /***************************************************************************/
// /**************************** REQUEST **************************************/
////////////////////////////////////////////////////////////////////////////////
var task_is_already_accepted_EN = "Task is already accepted by someone else.";

////////////////////////////////////////////////////////////////////////////////
// /***************************************************************************/
class ConvertLanguage {
  funcConvertLanguage(
    String viewClass,
    String selectedLanguage,
  ) {
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (kDebugMode) {
    //   print('USER SELECTED ====>${prefs.getString('selected_language')}');
    // }
    //

    if (kDebugMode) {
      // print('USER SELECTED ====>$selectedLanguage}');
    }
    if (viewClass == class_name_selected_language) {
      if (selectedLanguage == 'en') {
        return select_language_en;
      } else {
        return select_language_sp;
      }
    } else if (viewClass == 'select_language_spanish_alert') {
      if (selectedLanguage == 'en') {
        return select_language_alert_en;
      } else {
        return select_language_alert_sp;
      }
    }

    ///
    /// MENU BAR
    ///
    else if (viewClass == 'menu_dashboard') {
      if (selectedLanguage == 'en') {
        return menu_bar_dashboard_en;
      } else {
        return menu_bar_dashboard_sp;
      }
    } else if (viewClass == 'menu_edit_profile') {
      if (selectedLanguage == 'en') {
        return menu_bar_edit_profile_en;
      } else {
        return menu_bar_edit_profile_sp;
      }
    } else if (viewClass == 'menu_q_a') {
      if (selectedLanguage == 'en') {
        return menu_bar_q_a_en;
      } else {
        return menu_bar_q_a_sp;
      }
    } else if (viewClass == 'menu_order_history') {
      if (selectedLanguage == 'en') {
        return menu_bar_order_hostry_en;
      } else {
        return menu_bar_order_hostry_sp;
      }
    } else if (viewClass == 'menu_help') {
      if (selectedLanguage == 'en') {
        return menu_bar_help_en;
      } else {
        return menu_bar_help_sp;
      }
    } else if (viewClass == 'menu_change_password') {
      if (selectedLanguage == 'en') {
        return menu_bar_change_password_en;
      } else {
        return menu_bar_change_password_sp;
      }
    } else if (viewClass == 'menu_language') {
      if (selectedLanguage == 'en') {
        return menu_bar_language_en;
      } else {
        return menu_bar_language_sp;
      }
    } else if (viewClass == 'menu_settings') {
      if (selectedLanguage == 'en') {
        return menu_bar_settings_en;
      } else {
        return menu_bar_settings_sp;
      }
    } else if (viewClass == 'menu_logout') {
      if (selectedLanguage == 'en') {
        return menu_bar_logout_en;
      } else {
        return menu_bar_logout_sp;
      }
    }

    ///
    /// DASHBOARD
    ///
    else if (viewClass == 'dashboard_goal') {
      if (selectedLanguage == 'en') {
        return dashboard_goal_en;
      } else {
        return dashboard_goal_sp;
      }
    } else if (viewClass == 'dashboard_sub_goal') {
      if (selectedLanguage == 'en') {
        return dashboard_sub_goals_en;
      } else {
        return dashboard_sub_goals_sp;
      }
    } else if (viewClass == 'dashboard_quest') {
      if (selectedLanguage == 'en') {
        return dashboard_quest_en;
      } else {
        return dashboard_quest_sp;
      }
    } else if (viewClass == 'dashboard_mission') {
      if (selectedLanguage == 'en') {
        return dashboard_mission_en;
      } else {
        return dashboard_mission_sp;
      }
    } else if (viewClass == 'dashboard_task') {
      if (selectedLanguage == 'en') {
        return dashboard_task_en;
      } else {
        return dashboard_task_sp;
      }
    } else if (viewClass == 'dashboard_training') {
      if (selectedLanguage == 'en') {
        return dashboard_training_en;
      } else {
        return dashboard_training_sp;
      }
    } else if (viewClass == 'dashboard_grind') {
      if (selectedLanguage == 'en') {
        return dashboard_grinds_en;
      } else {
        return dashboard_grinds_sp;
      }
    } else if (viewClass == 'dashboard_habit') {
      if (selectedLanguage == 'en') {
        return dashboard_habits_en;
      } else {
        return dashboard_habits_sp;
      }
    } else if (viewClass == 'dashboard_quotes') {
      if (selectedLanguage == 'en') {
        return dashboard_quotes_en;
      } else {
        return dashboard_quotes_sp;
      }
    } else if (viewClass == 'dashboard_skills') {
      if (selectedLanguage == 'en') {
        return dashboard_skills_en;
      } else {
        return dashboard_skills_sp;
      }
    } else if (viewClass == 'dashboard_friends') {
      if (selectedLanguage == 'en') {
        return dashboard_friends_en;
      } else {
        return dashboard_friends_en;
      }
    } else if (viewClass == 'dashboard_requests') {
      if (selectedLanguage == 'en') {
        return dashboard_requests_en;
      } else {
        return dashboard_requests_en;
      }
    } else if (viewClass == 'dashboard_notes') {
      if (selectedLanguage == 'en') {
        return dashboard_notes_en;
      } else {
        return dashboard_notes_sp;
      }
    } else if (viewClass == 'dashboard_inventory') {
      if (selectedLanguage == 'en') {
        return dashboard_inventory_en;
      } else {
        return dashboard_inventory_sp;
      }
    } else if (viewClass == 'dashboard_shops') {
      if (selectedLanguage == 'en') {
        return dashboard_shops_en;
      } else {
        return dashboard_shops_sp;
      }
    } else if (viewClass == 'dashboard_actions') {
      if (selectedLanguage == 'en') {
        return dashboard_actions_en;
      } else {
        return dashboard_actions_sp;
      }
    } else if (viewClass == 'dashboard_guilds') {
      if (selectedLanguage == 'en') {
        return dashboard_guilds_en;
      } else {
        return dashboard_guilds_sp;
      }
    }
  }
}
