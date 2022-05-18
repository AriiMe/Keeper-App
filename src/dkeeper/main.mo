import List "mo:base/List";
import Debug "mo:base/Debug";
//main canister
actor DKeeper {
  //datatype to store content
  public type Note  = {
    title: Text;
    content: Text;
  };
  //create list that has empty Note stored
  //stable makes the list persistent and notes won't be removed when redeploying
  stable var notes: List.List<Note> = List.nil<Note>();

  //public function for user inputs
  public func createNote(titleText: Text, contentText: Text){

    let newNote: Note = {
      title = titleText;
      content = contentText;
    };
    //creates new list with new note
    notes := List.push(newNote, notes);
    Debug.print(debug_show(notes));
  };

  //showing stored data for frontend, query is lighter and faster
  public query func readNotes(): async [Note] {
    return List.toArray(notes);
  }; 

  //removing notes from backend
  public func removeNote(id: Nat) {
    //take drop append
    let listFront = List.take(notes, id);
    let listBack = List.drop(notes, id + 1);
    notes := List.append(listFront, listBack);
  };

};
