//
//  Constants.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 21/10/2019.
//

import Foundation

//PRODUCTION URL Constants
let URL_PRODUCTION = "https://demo.com:8443/v1"

let URL_STAGING = "http://13.233.38.119:8080/v1"

let BASE_URL = URL_PRODUCTION
//let BASE_DIRECTORY_PATH = "https://demo.com/demo/"
let BASE_DIRECTORY_PATH = "https://demo.com/" //PRODUCTION
//let BASE_DIRECTORY_PATH = "http://13.233.38.119/" //STAGING


let API_SIGNIN = "\(BASE_URL)/login"
/// Parameters 1.oldPassword 2.newPassword POST
let API_RESET_PASSWORD = "\(BASE_URL)/user/resetPasswordByUser"
let API_LOGOUT = "\(BASE_URL)/logout"

//************ALERT API************//

///Parameters 1.alertId
let API_GET_ALERT_BY_ID = "\(BASE_URL)/alert/getDeliverAlertById"

///Parameters 1.date 2.offset 3.limit
let API_GET_ALERTS_AFTER_GIVEN_DATE = "\(BASE_URL)/alert/getAlertAfterGivenDate"

///Parameters 1.alertId 2.favourite
let API_FAVOURITE_ALERT = "\(BASE_URL)/alert/addUpdateFavouriteState"

///Parameters 1.alertId
let API_READ_ALERT_STATUS = "\(BASE_URL)/alert/setReadState"

///Parameters 1.alertid 2.feedback
let API_ALERT_ADD_FEEDBACK = "\(BASE_URL)/alert/addFeedback"

///Parameters 1.alertid
let API_GET_ALERT_FEEDBACK = "\(BASE_URL)/alert/getFeedback"

let API_GET_JWT = "\(BASE_URL)/getJwtToken"

enum CATEGORY_TYPE:String {
  case ALERT = "Alert"
  case RSVP = "Rsvp"
  case NEWSLETTER = "Newsletter"
  case ECALENDAR = "eCalendar"
  case POLL = "Poll"
  case ANNOUNCEMENT = "CEO Message"
  case SURVEY = "Survey"
  case SOCIALIMPACT = "Social Impact"
  case RECOGNITION = "Recognition"

}


enum NOTIFICATION_TYPES:String {
  case ALERT = "Alert"
  case RSVP = "Rsvp"
  case SURVEY = "Survey"
  case NEWSLETTER = "Newsletter"
  case ECALENDAR = "eCalendar"
  case POLL = "Poll"
  case CEOMESSAGE = "CEO Message"
  case ANNOUNCEMENT = "Announcement"
  case DELETE_USER = "deleteUser"
  case CHANGE_ROLE = "changeRole"
  case ADD_EDIT_ECALENDAR = "Add/EditECalendar"
  case DELETE_ECALENDAR = "deleteECalendar"
  case DELETE_ALERT = "deleteAlert"
  case DELETE_SURVEY = "deleteSurvey"
  case DELETE_RSVP = "deleteRsvp"
  case DELETE_POLL = "deletePoll"
  case DELETE_NEWSLETTER = "deleteNewsletter"
  case DELETE_ANNOUNCEMENT = "deleteAnnouncement"

}

enum LISTVIEW_TYPE:String {
  case ALL = "All"
  case ALERT = "Alert"
  case TODAY = "Today"
  case FLAGGED = "Flagged"
  case ECALENDAR = "eCalendar"
  case RSVP = "Rsvp"
  case NEWSLETTER = "Newsletter"
  case POLL = "Poll"
  case ANNOUNCEMENT = "CEO Message"
  case SURVEY = "Survey"
  case RECOGNITION = "Recognition"
  case SOCIALIMPACT = "Social Impact"

}

enum SCHEDULE_TYPE:String {
  case REGULAR = "regular"
  case CHOLIDARY = "choliday"
  case TENTATIVE = "tentative"
  case NCHOLIDAY = "ncholiday"


}

enum DATE_FORMATES:String {
  case FULL_FORMAT = "yyyy-MM-dd HH:mm:ss"
  case TIME_AM_PM = "hh:mm a"
  case DATE = "yyyy-MM-dd"
  case HEADER_DATE = "MMM dd, yyyy"
  case HEADER_DATE_WITH_DAY_NAME = "EEEE, MMM d, yyyy"
  case YEAR_MONTH = "yyyy-MM"
  case DAY = "dd"
  case MONTH = "MM"
  case YEAR = "yyyy"


}

// Rights

enum SCREEN_ACTIONS:String {
  
  ///User dosent have privilege for Alerts
//  case GET_ALERTS_AFTER_GIVEN_DATE = "ual_104"
//  case GET_RSVP_AFTER_GIVEN_DATE = "uev_104"

  // Alert
  case GET_ALERT_OF_TODAY_DATE = "ual_100";
  case GET_ALL_ALERT_LIST = "ual_101";
  case GET_ALERT_BY_ID = "ual_102";
  case GET_ALERT_AFTER_GIVEN_ID = "ual_103";
  case GET_ALERT_AFTER_GIVEN_DATE = "ual_104";

  // Survey
   case GET_SURVEY_OF_TODAY_DATE = "usrv_100"
   case GET_ALL_SURVEY_LIST = "usrv_101"
   case GET_SURVEY_BY_ID = "usrv_102"
   case GET_SURVEY_AFTER_GIVEN_ID = "usrv_103"
   case GET_SURVEY_AFTER_GIVEN_DATE = "usrv_104"

  //Rsvp
  case GET_RSVP_OF_TODAY_DATE = "uev_100";
  case GET_RSVP_LIST = "uev_101";
  case GET_RSVP_BY_ID = "uev_102";
  case GET_RSVP_AFTER_GIVEN_ID = "uev_103";
  case GET_RSVP_AFTER_GIVEN_DATE = "uev_104";

  //News Letter
  case GET_NEWS_LETTER_OF_TODAY_DATE = "unl_100";
  case GET_NEWS_LETTER_LIST = "unl_101";
  case GET_NEWS_LETTER_BY_ID = "unl_102";
  case GET_NEWS_LETTER_AFTER_GIVEN_ID = "unl_103";
  case GET_NEWS_LETTER_AFTER_GIVEN_DATE = "unl_104";

  //Poll
  case GET_POLL_OF_TODAY_DATE = "upoll_100";
  case GET_POLL_LIST = "upoll_101";
  case GET_POLL_BY_ID = "upoll_102";
  case GET_POLL_AFTER_GIVEN_ID = "upoll_103";
  case GET_POLL_AFTER_GIVEN_DATE = "upoll_104";
  
  
//Schedule
  case GET_SCHEDULE  = "evc_101";
  case SCHEDULE_ADD  = "evc_103"
  case SCHEDULE_EDIT  = "evc_104"

  //Announcements
  case ADD_ANNOUNCEMENT = "aann_100";
  case UPDATE_ANNOUNCEMENT = "aann_101";
  case DELETE_ANNOUNCEMENT = "aann_102";
  
  case GET_ANNOUNCEMENT_OF_TODAY_DATE = "uann_100";
  case GET_ANNOUNCEMENT_LIST = "uann_101";
  case GET_ANNOUNCEMENT_BY_ID = "uann_102";
  case GET_ANNOUNCEMENT_AFTER_GIVEN_ID = "uann_103";
  case GET_ANNOUNCEMENT_AFTER_GIVEN_DATE = "uann_104";

}

//inc act
enum PAYLOAD_STATUS:String {
  case ACTIVE = "act"
  case INACTIVE = "ina"
}

enum TOGGLE_CALENDAR {
  case SHOW
  case HIDE
}
enum LISTVIEW_TOGGLE {
  case DEFAULT
  case SEARCH
  case CALENDAR
}

enum DARK_THEME_COLORS:String{

  case BLACK_WHITE_TEXT = "Black Text Dark Theme"
  case BLUE_WHITE_TEXT = "Blue Text Dark Theme"
  case CALENDAR_HEADER = "Calendar Header Title"
  case DARK_GREY_WHITE = "Dark Grey Dark Theme"
  case LIGHT_LINE_SEPERATOR = "Light Line seperator Dark Theme"
  case DARK_LINE_SEPERATOR = "Line seperator Dark Theme"
  case MAINVIEW_WHITE_GREY = "Main View Light Grey Background Dark Theme"
  case PLACE_HOLDER_ACTIVE = "PlaceHolder Active Dark Theme"
  case PLACE_HOLDER_NORMAL = "PlaceHolder Normal Dark Theme"
  case TOAST_BACKGROUND = "Toast Background Theme"
  case TOAST_TEXT = "Toast Text Theme"
  case WHITE_GREY = "White And Grey Background Dark Theme"
  case WHITE_BLACK = "White Background Dark Theme"
  case PERCENTAGE_BLUE_TEXT = "Percentage Text Dark Theme"
  case RSVP_CELL = "RsvpCellBackground"
}

let TEXT_SIZE_HUGE = 27.0
let TEXT_SIZE_XLARGE = 23.0
let TEXT_SIZE_LARGE = 19.0
let TEXT_SIZE_MEDIUM = 16.0
let TEXT_SIZE_MEDIUM_SMALL = 15.0
let TEXT_SIZE_SMALL = 13.0
let TEXT_SIZE_XSMALL = 10.0

let FONT_FAMILY_AVENIR_LIGHT = "Avenir-Light"
let FONT_FAMILY_AVENIR_BOOK = "Avenir-Book"
let FONT_FAMILY_AVENIR_HEAVY = "Avenir-Heavy"

let DEFAULT_KEY_IS_FIRST_TIME_LOGIN = "isFirstTimeLoginn_"
let DEFAULT_KEY_JWT_TOKEN = "jwtToken"
let DEFAULT_KEY_JWT_OBJECT = "jwtObject"
let DEFAULT_KEY_VOIP_TOKEN = "voipToken"
let DEFAULT_KEY_DEVICE_TOKEN = "deviceToken"
let DEFAULT_KEY_IS_LOGGED_IN = "isUserLoggedIn_"


//NOTIFICATION
let NOTIFICATION_KEY_TYPE = "type"
let NOTIFICATION_KEY_TITLE = "title"
let NOTIFICATION_KEY_BODY = "body"
let NOTIFICATION_KEY_SHOW = "show"
let NOTIFICATION_KEY_NOTIFICATION_TYPE = "notificationType"
let NOTIFICATION_KEY_NOTIFICATION_ID = "notificationId"
let NOTIFICATION_KEY_NOTIFICATION_TYPE_ID = "typeId"
let NOTIFICATION_KEY_OCCURRENCE = "occurrence"





//DATABASE TABLES


//Schedule
let TB_SCHEDULE = "scheduleSQLite"
let TBC_SCHEDULE_ID = "scheduleid"
let TBC_SCHEDULE_NAME = "name"
let TBC_SCHEDULE_CREATION_DATE = "creationdate"
let TBC_SCHEDULE_MODIFICATION_DATE = "modificationdate"
let TBC_SCHEDULE_TYPE = "type"
let TBC_SCHEDULE_YEAR = "year"
let TBC_SCHEDULE_FAVOURITE = "favourite"
let TBC_SCHEDULE_USER_ID = "userId"
let TBC_SCHEDULE_DATE = "date"
let TBC_SCHEDULE_START_TIME = "startTime"
let TBC_SCHEDULE_END_TIME = "endTime"
let TBC_SCHEDULE_LOCATION = "location"
let TBC_SCHEDULE_SUMMARY = "summary"
let TBC_SCHEDULE_PATH = "path"


//NewsLetter
let TB_NEWSLETTER = "newsletterSQLite"
let TBC_NEWS_LETTER_ID = "newsletterid"
let TBC_NEWS_LETTER_NAME = "name"
let TBC_NEWS_LETTER_SUMMARY = "summary"
let TBC_NEWS_LETTER_FEEDBACK = "feedback"
let TBC_NEWS_LETTER_PATH = "path"
let TBC_NEWS_LETTER_CREATION_DATE = "creationdate"
let TBC_NEWS_LETTER_MODIFICATION_DATE = "modificationdate"
let TBC_NEWS_LETTER_STATE = "state"
let TBC_NEWS_LETTER_STATUS = "status"
let TBC_NEWS_LETTER_RSTATUS = "rstatus"
let TBC_NEWS_LETTER_BUSINESSID = "businessid"
let TBC_NEWS_LETTER_FAVOURITE = "favourite"

let TB_NEWS_LETTER_SETTING = "newsletterSettingSQLite"
let TBC_NEWS_LETTER_SETTING_ID = "newslettersettingid"
let TBC_NEWS_LETTER_SETTING_NEWS_LETTER_ID_FK = "newsletterid"
let TBC_NEWS_LETTER_SETTING_STAY_TIME = "staytime"
let TBC_NEWS_LETTER_SETTING_NOTIFICATION_TYPE = "notificationtype"
let TBC_NEWS_LETTER_SETTING_OCCURRENCE = "occurrence"
let TBC_NEWS_LETTER_SETTING_LOCAL_OCCURRENCE = "localoccurrence"
let TBC_NEWS_LETTER_SETTING_RECURRENCE = "recurrence"
let TBC_NEWS_LETTER_SETTING_CREATION_DATE = "creationdate"
let TBC_NEWS_LETTER_SETTING_MODIFICATION_DATE = "modificationdate"
let TBC_NEWS_LETTER_SETTING_DISPLAY_TIME = "displaydatetime"

//ALERTS
let TB_ALERT = "alertSQLite"
let TBC_ALERT_ID = "alertid"
let TBC_ALERT_NAME = "name"
let TBC_ALERT_SUMMARY = "summary"
let TBC_ALERT_FEEDBACK = "feedback"
let TBC_ALERT_PATH = "path"
let TBC_ALERT_CREATION_DATE = "creationdate"
let TBC_ALERT_MODIFICATION_DATE = "modificationdate"
let TBC_ALERT_STATE = "state"
let TBC_ALERT_STATUS = "status"
let TBC_ALERT_RSTATUS = "rstatus"
let TBC_ALERT_BUSINESSID = "businessid"
let TBC_ALERT_FAVOURITE = "favourite"

let TB_ALERT_SETTING = "alertSettingSQLite"
let TBC_ALERT_SETTING_ID = "alertsettingid"
let TBC_ALERT_SETTING_ALERT_ID_FK = "alertid"
let TBC_ALERT_SETTING_STAY_TIME = "staytime"
let TBC_ALERT_SETTING_NOTIFICATION_TYPE = "notificationtype"
let TBC_ALERT_SETTING_OCCURRENCE = "occurrence"
let TBC_ALERT_SETTING_LOCAL_OCCURRENCE = "localoccurrence"
let TBC_ALERT_SETTING_RECURRENCE = "recurrence"
let TBC_ALERT_SETTING_CREATION_DATE = "creationdate"
let TBC_ALERT_SETTING_MODIFICATION_DATE = "modificationdate"
let TBC_ALERT_SETTING_DISPLAY_TIME = "displaydatetime"


//ANNOUNCEMENT
let TB_ANNOUNCEMENT = "announcementSQLite"
let TBC_ANNOUNCEMENT_ID = "announcementid"
let TBC_ANNOUNCEMENT_NAME = "name"
let TBC_ANNOUNCEMENT_SUMMARY = "summary"
let TBC_ANNOUNCEMENT_CREATEBY = "createdBy"
let TBC_ANNOUNCEMENT_DESCRIPTION = "description"
let TBC_ANNOUNCEMENT_FEEDBACK = "feedback"
let TBC_ANNOUNCEMENT_PATH = "path"
let TBC_ANNOUNCEMENT_CREATION_DATE = "creationdate"
let TBC_ANNOUNCEMENT_MODIFICATION_DATE = "modificationdate"
let TBC_ANNOUNCEMENT_STATE = "state"
let TBC_ANNOUNCEMENT_STATUS = "status"
let TBC_ANNOUNCEMENT_RSTATUS = "rstatus"
let TBC_ANNOUNCEMENT_BUSINESSID = "businessid"
let TBC_ANNOUNCEMENT_FAVOURITE = "favourite"


let TB_ANNOUNCEMENT_SETTING = "announcementSettingSQLite"
let TBC_ANNOUNCEMENT_SETTING_ID = "announcementsettingid"
let TBC_ANNOUNCEMENT_SETTING_ANNOUNCEMENT_ID_FK = "announcementid"
let TBC_ANNOUNCEMENT_SETTING_STAY_TIME = "staytime"
let TBC_ANNOUNCEMENT_SETTING_NOTIFICATION_TYPE = "notificationtype"
let TBC_ANNOUNCEMENT_SETTING_OCCURRENCE = "occurrence"
let TBC_ANNOUNCEMENT_SETTING_LOCAL_OCCURRENCE = "localoccurrence"
let TBC_ANNOUNCEMENT_SETTING_RECURRENCE = "recurrence"
let TBC_ANNOUNCEMENT_SETTING_CREATION_DATE = "creationdate"
let TBC_ANNOUNCEMENT_SETTING_MODIFICATION_DATE = "modificationdate"
let TBC_ANNOUNCEMENT_SETTING_DISPLAY_TIME = "displaydatetime"

let TB_COMMON_CATEGORIES = "CommonCategoriesSQLite"
let TBC_COMMON_CATEGORIES_ID = "id"
let TBC_COMMON_CATEGORIES_NAME = "name"
let TBC_COMMON_CATEGORIES_SUMMARY = "summary"
let TBC_COMMON_CATEGORIES_CREATEBY = "createdBy"
let TBC_COMMON_CATEGORIES_DESCRIPTION = "description"
let TBC_COMMON_CATEGORIES_TYPE = "type"
let TBC_COMMON_CATEGORIES_FAVOURITE = "favourite"
let TBC_COMMON_CATEGORIES_DISPLAY_DATETIME = "displaydatetime"
let TBC_COMMON_CATEGORIES_STATUS = "status"
let TBC_COMMON_CATEGORIES_FEEDBACK = "feedback"
let TBC_COMMON_CATEGORIES_PATH = "path"
let TBC_COMMON_CATEGORIES_OCCURRENCE = "occurrence"
let TBC_COMMON_CATEGORIES_SELECTED_OPTION_ID = "selectedOptionId"
let TBC_COMMON_CATEGORIES_SCHEDULE_TYPE = "scheduleType"
let TBC_COMMON_CATEGORIES_SCHEDULE_YEAR = "year"
let TBC_COMMON_CATEGORIES_SCHEDULE_START_TIME = "startTime"
let TBC_COMMON_CATEGORIES_SCHEDULE_END_TIME = "endTime"
let TBC_COMMON_CATEGORIES_SCHEDULE_USER_ID = "userId"
let TBC_COMMON_CATEGORIES_SCHEDULE_LOCATION = "location"
let TBC_COMMON_CATEGORIES_SURVEY_SUBMITTED = "surveySubmitted"



//RSVP TABLES
let TB_RSVP = "rsvpSQLite"
let TBC_RSVP_ID = "rsvpid"
let TBC_RSVP_NAME = "name"
let TBC_RSVP_IMAGE = "imagePath"
let TBC_RSVP_QUESTION = "question"
let TBC_RSVP_SUMMARY = "summary"
let TBC_RSVP_DATE = "date"
let TBC_RSVP_START_TIME = "startTime"
let TBC_RSVP_END_TIME = "endTime"
let TBC_RSVP_LOCATION = "location"
let TBC_RSVP_POLL_IS_UPDATE = "isPollUpdateEnabled"
let TBC_RSVP_FEEDBACK = "feedback"
let TBC_RSVP_PATH = "path"
let TBC_RSVP_CREATION_DATE = "creationdate"
let TBC_RSVP_MODIFICATION_DATE = "modificationdate"
let TBC_RSVP_STATE = "state"
let TBC_RSVP_STATUS = "status"
let TBC_RSVP_RSTATUS = "rstatus"
let TBC_RSVP_BUSINESSID = "businessid"
let TBC_RSVP_FAVOURITE = "favourite"
let TBC_RSVP_SELECTED_OPTION_ID = "selectedOptionId"

let TB_RSVP_SETTING = "rsvpSettingSQLite"
let TBC_RSVP_SETTING_ID = "rsvpsettingid"
let TBC_RSVP_SETTING_RSVP_ID_FK = "rsvpid"
let TBC_RSVP_SETTING_STAY_TIME = "staytime"
let TBC_RSVP_SETTING_NOTIFICATION_TYPE = "notificationtype"
let TBC_RSVP_SETTING_OCCURRENCE = "occurrence"
let TBC_RSVP_SETTING_RECURRENCE = "recurrence"
let TBC_RSVP_SETTING_CREATION_DATE = "creationdate"
let TBC_RSVP_SETTING_MODIFICATION_DATE = "modificationdate"
let TBC_RSVP_SETTING_DISPLAY_TIME = "displaydatetime"

let TB_RSVP_OPTIONS = "rsvpSelectedOptionsSQLite"
let TBC_RSVP_OPTIONS_RSVP_ID_FK = "rsvpid"
let TBC_RSVP_OPTIONS_POLL_OPTION_FK = "polloptionid"
let TBC_RSVP_OPTIONS_PERCENTAGE = "percentage"
let TBC_RSVP_OPTIONS_COUNT = "count"

//EVENT POLL OPTION
let TB_RSVP_POLL_OPTION = "rsvpOptionsSQLite"
let TBC_RSVP_POLL_OPTION_ID = "polloptionid"
let TBC_RSVP_POLL_OPTION_NAME = "name"
let TBC_RSVP_POLL_OPTION_DESCRIPTION = "description"





//POLL TABLES
let TB_POLL = "pollSQLite"
let TBC_POLL_ID = "pollid"
let TBC_POLL_NAME = "name"
let TBC_POLL_SUMMARY = "summary"
let TBC_POLL_IMAGE = "imagePath"
let TBC_POLL_QUESTION = "question"
let TBC_POLL_IS_UPDATE = "isPollUpdateEnabled"
let TBC_POLL_FEEDBACK = "feedback"
let TBC_POLL_PATH = "path"
let TBC_POLL_CREATION_DATE = "creationdate"
let TBC_POLL_MODIFICATION_DATE = "modificationdate"
let TBC_POLL_STATE = "state"
let TBC_POLL_STATUS = "status"
let TBC_POLL_RSTATUS = "rstatus"
let TBC_POLL_BUSINESSID = "businessid"
let TBC_POLL_FAVOURITE = "favourite"
let TBC_POLL_SELECTED_OPTION_ID = "selectedOptionId"

let TB_POLL_SETTING = "pollSettingSQLite"
let TBC_POLL_SETTING_ID = "pollsettingid"
let TBC_POLL_SETTING_POLL_ID_FK = "pollid"
let TBC_POLL_SETTING_STAY_TIME = "staytime"
let TBC_POLL_SETTING_NOTIFICATION_TYPE = "notificationtype"
let TBC_POLL_SETTING_OCCURRENCE = "occurrence"
let TBC_POLL_SETTING_RECURRENCE = "recurrence"
let TBC_POLL_SETTING_CREATION_DATE = "creationdate"
let TBC_POLL_SETTING_MODIFICATION_DATE = "modificationdate"
let TBC_POLL_SETTING_DISPLAY_TIME = "displaydatetime"

let TB_POLL_OPTIONS = "pollSelectedOptionsSQLite"
let TBC_POLL_OPTIONS_POLL_ID_FK = "pollid"
let TBC_POLL_OPTIONS_POLL_OPTION_FK = "polloptionid"
let TBC_POLL_OPTIONS_PERCENTAGE = "percentage"
let TBC_POLL_OPTIONS_COUNT = "count"
let TBC_POLL_OPTIONS_TOTAL_COUNT = "totalCount"

//EVENT POLL OPTION
let TB_POLL_POLL_OPTION = "pollOptionsSQLite"
let TBC_POLL_POLL_OPTION_ID = "polloptionid"
let TBC_POLL_POLL_OPTION_NAME = "name"
let TBC_POLL_POLL_OPTION_DESCRIPTION = "description"



//SURVEY
let TB_SURVEY = "surveySQLite"
let TBC_SURVEY_ID = "surveyid"
let TBC_SURVEY_NAME = "name"
let TBC_SURVEY_SUMMARY = "summary"
let TBC_SURVEY_FEEDBACK = "feedback"
let TBC_SURVEY_PATH = "path"
let TBC_SURVEY_CREATION_DATE = "creationdate"
let TBC_SURVEY_MODIFICATION_DATE = "modificationdate"
let TBC_SURVEY_STATE = "state"
let TBC_SURVEY_STATUS = "status"
let TBC_SURVEY_RSTATUS = "rstatus"
let TBC_SURVEY_BUSINESSID = "businessid"
let TBC_SURVEY_FAVOURITE = "favourite"
let TBC_SURVEY_SUBMITTED = "surveySubmitted"

let TB_SURVEY_SETTING = "surveySettingSQLite"
let TBC_SURVEY_SETTING_ID = "surveysettingid"
let TBC_SURVEY_SETTING_SURVEY_ID_FK = "surveyid"
let TBC_SURVEY_SETTING_STAY_TIME = "staytime"
let TBC_SURVEY_SETTING_NOTIFICATION_TYPE = "notificationtype"
let TBC_SURVEY_SETTING_OCCURRENCE = "occurrence"
let TBC_SURVEY_SETTING_LOCAL_OCCURRENCE = "localoccurrence"
let TBC_SURVEY_SETTING_RECURRENCE = "recurrence"
let TBC_SURVEY_SETTING_CREATION_DATE = "creationdate"
let TBC_SURVEY_SETTING_MODIFICATION_DATE = "modificationdate"
let TBC_SURVEY_SETTING_DISPLAY_TIME = "displaydatetime"


typealias completionHandler = (_ isCompleted: Bool) -> ()
