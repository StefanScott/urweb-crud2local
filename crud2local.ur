table t : {
  Id : int, 
  Nam : string, 
  Ready : bool, 
  LocalStatus : int }
  PRIMARY KEY Id

open Crud.Make(struct
  val tab = t
  
  val title = "Are you Ready? Select a Local Status."

  val cols = {
    Nam = Crud.string "Name",

    Ready = {
      Nam = "Ready?",

      Show = (fn b => 
       if b then
         <xml>Ready!</xml>
       else
         <xml>Not ready</xml>),

      Widget = (fn [nm :: Name] => 
        <xml>
          <select{nm}>
            <option>Ready</option>
            <option>Not ready</option>
          </select>
        </xml>),

      WidgetPopulated = (fn [nm :: Name] b => 
      <xml>
        <select{nm}>
          <option selected={b}>Ready</option>
          <option selected={not b}>Not ready</option>
        </select>
      </xml>),

      Parse = (fn s =>
        case s of
            "Ready" => True
          | "Not ready" => False
          | _ => error <xml>Invalid ready/not ready</xml>),

      Inject = _
    },

    LocalStatus = {
      Nam = "Local Status",

      Show = (fn ls => 
       case ls of 
           1 => <xml>Local One!</xml>
         | 2 => <xml>Local Two!</xml>
         | 3 => <xml>Local Three!</xml>
         | _ => error <xml> Invalid Local Status!</xml>),

      Widget = (fn [nm :: Name] => 
        <xml>
          <select{nm}>
            <option>Local One!</option>
            <option>Local Two!</option>
            <option>Local Three!</option>
          </select>
        </xml>),

      WidgetPopulated = (fn [nm :: Name] ls => 
      <xml>
          <select{nm}>
            <option selected={ls=1}>Local One!</option>
            <option selected={ls=2}>Local Two!</option>
            <option selected={ls=3}>Local Three!</option>
          </select>
      </xml>),

      Parse = (fn ls =>
        case ls of
            "Local One!" => 1
          | "Local Two!" => 2
          | "Local Three!" => 3
          | _ => error <xml>Invalid Local Status!</xml>),

      Inject = _
    }
  }
end)