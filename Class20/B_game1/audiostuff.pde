
void playhalf()
{
  int voicematch = -1;
  for(int i = 0;i<groove.length;i++)
  {
     if(groove[i].isPlaying()==false)
    {
       voicematch = i;
       break;
    } 
  }
  if(voicematch>-1) {
    groove[voicematch].cue(0);
    groove[voicematch].play();
  }
  
  
}
