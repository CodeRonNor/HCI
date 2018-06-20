import java.util.List;
import java.util.LinkedList;

class HighScore{
  private LinkedList userList;
  private BufferedReader reader;
  private String line;
  private PrintWriter output;
  private String fileName;
  
  public HighScore(String fileName){
    userList = new LinkedList();
    this.fileName = fileName;
  }
  
  public void addUser(String name, int highScoreValue){
    // we read all scores in the file and put all of them in our list
    readScores();
    // we add an additional person in our list
    addUserToUserList(name, highScoreValue);
    // we write the list in our scores file
    writeScoresToFile();
  }
  
  public LinkedList getUsersList(){
    readScores();
    return userList;
  }
  
  private void readScores(){
    reader = createReader(fileName);
    try {
      line = reader.readLine();
      if (line != null){
        String[] lines = loadStrings(fileName);
        //println("there are " + lines.length + " lines");
        for (int i = 0; i < lines.length; i++) {
          //println(lines[i]);
          loadUserIntoList(i+1 + ". " + lines[i]);
        }
      }
      reader.close();
    }
    catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    
  }
  
  private void loadUserIntoList(String line){
    String name = "";
    String score = "";
    boolean semicolon = false;
    int amountOfCharacters = 0;
    
    // get the information out of the string line
    for (int i = 0; i < line.length(); i++){
      if (line.charAt(i) == ','){
        semicolon = true;
        amountOfCharacters++;
      }
      if (!semicolon){
        name += line.charAt(i);
      } else {
        if (amountOfCharacters > 2){
          score += line.charAt(i);
        }
        amountOfCharacters++;
      }
    }
    // put the information (name, score) to the HashMap
    try {
      addUserToUserList(name, Integer.parseInt(score));
    }
    catch (Exception e){
      println("Player: " + name + " could not be added to the Database");
    }
  }
  
  private void addUserToUserList(String name, int newScore){
    LinkedList newUser = new LinkedList();
    newUser.add(name);
    newUser.add(newScore);
    
    // if list is empty
    if (userList.size() < 1){
      userList.add(newUser);
    }
    else {
      int iterations = userList.size();
      boolean userAdded = false;
      for (int i = 0; i < iterations; i++) {
        LinkedList currentUser = (LinkedList) userList.get(i);
        int currentScore = (int) currentUser.get(1); //.get(1) == score
        if (newScore > currentScore) {
          userList.add(i, newUser);
          userAdded = true;
          break;
        }
      }
      
      if (userAdded == false){
        userList.addLast(newUser);
      }
    }
  }
  
  private void writeNamesIntoFile(){
    for (int i = 0; i < userList.size(); i++){
      LinkedList currentUser = (LinkedList) userList.get(i);
      String currentUsersName = (String) currentUser.get(0);
      int currentUsersScore = (int) currentUser.get(1);
      
    }
  }

  private void writeScoresToFile(){
    // iterate through the map and add them to the scores.txt
    output = createWriter(fileName);
    
    for (int i = 0; i < userList.size(); i++){
      LinkedList currentUser = (LinkedList) userList.get(i);
      String currentUsersName = (String) currentUser.get(0);
      int currentUsersScore = (int) currentUser.get(1);
      String newUser = currentUsersName + ", " + currentUsersScore;
      output.println(newUser);
    }
    //String newScore = name + ", " + score;
    //output.println(newScore);
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
  }
}
