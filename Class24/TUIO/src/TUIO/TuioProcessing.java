/*
	TUIO Processing library
	Copyright (c) 2005-2014 Martin Kaltenbrunner <martin@tuio.org>
 
	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 3.0 of the License, or (at your option) any later version.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
	Lesser General Public License for more details.
	 
	You should have received a copy of the GNU Lesser General Public
	License along with this library.
*/

package TUIO;

import java.awt.event.*;
import java.lang.reflect.*;
import processing.core.*;
import java.util.*;

public class TuioProcessing implements TuioListener {
		
	private PApplet parent;
	private Method addTuioObject, removeTuioObject, updateTuioObject, addTuioCursor, removeTuioCursor, updateTuioCursor, addTuioBlob, removeTuioBlob, updateTuioBlob, refresh;
	private TuioClient client;
			
	public TuioProcessing(PApplet parent) {
		this(parent,3333);
	}
	
	public TuioProcessing(PApplet parent, int port) {
		this.parent = parent;
		parent.registerMethod("dispose",this);
		
		try { refresh = parent.getClass().getMethod("refresh",new Class[] { TuioTime.class } ); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'refresh(TuioTime bundleTime)' method implementation");
			refresh = null;
		}
		
		try { addTuioObject = parent.getClass().getMethod("addTuioObject", new Class[] { TuioObject.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'addTuioObject(TuioObject tobj)' method implementation");
			addTuioObject = null;
		}
		
		try { removeTuioObject = parent.getClass().getMethod("removeTuioObject", new Class[] { TuioObject.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'removeTuioObject(TuioObject tobj)' method implementation");
			removeTuioObject = null;
		}
		
		try { updateTuioObject = parent.getClass().getMethod("updateTuioObject", new Class[] { TuioObject.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'updateTuioObject(TuioObject tobj)' method implementation");
			updateTuioObject = null;
		}
		
		try { addTuioCursor = parent.getClass().getMethod("addTuioCursor", new Class[] { TuioCursor.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'addTuioCursor(TuioCursor tcur)' method implementation");
			addTuioCursor = null;
		}
		
		try { removeTuioCursor = parent.getClass().getMethod("removeTuioCursor", new Class[] { TuioCursor.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'removeTuioCursor(TuioCursor tcur)' method implementation");
			removeTuioCursor = null;
		}
		
		try { updateTuioCursor = parent.getClass().getMethod("updateTuioCursor", new Class[] { TuioCursor.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'updateTuioCursor(TuioCursor tcur)' method implementation");
			updateTuioCursor = null;
		}
		
		try { addTuioBlob = parent.getClass().getMethod("addTuioBlob", new Class[] { TuioBlob.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'addTuioBlob(TuioBlob tblb)' method implementation");
			addTuioCursor = null;
		}
		
		try { removeTuioBlob = parent.getClass().getMethod("removeTuioBlob", new Class[] { TuioBlob.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'removeTuioBlob(TuioBlob tblb)' method implementation");
			removeTuioCursor = null;
		}
		
		try { updateTuioBlob = parent.getClass().getMethod("updateTuioBlob", new Class[] { TuioBlob.class }); }
		catch (Exception e) { 
			System.out.println("TUIO: missing or wrong 'updateTuioBlobTuioBlob tblb)' method implementation");
			updateTuioCursor = null;
		}
		
		client = new TuioClient(port);
		client.addTuioListener(this);
		client.connect();
	}

	public void addTuioObject(TuioObject tobj) {
		if (addTuioObject!=null) {
			try { 
				addTuioObject.invoke(parent, new Object[] { tobj });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public void updateTuioObject(TuioObject tobj) {
		
		if (updateTuioObject!=null) {
			try { 
				updateTuioObject.invoke(parent, new Object[] { tobj });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public void removeTuioObject(TuioObject tobj) {
		if (removeTuioObject!=null) {
			try { 
				removeTuioObject.invoke(parent, new Object[] { tobj });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public void addTuioCursor(TuioCursor tcur) {
		if (addTuioCursor!=null) {
			try { 
				addTuioCursor.invoke(parent, new Object[] { tcur });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public void updateTuioCursor(TuioCursor tcur) {
		if (updateTuioCursor!=null) {
			try { 
				updateTuioCursor.invoke(parent, new Object[] { tcur });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public void removeTuioCursor(TuioCursor tcur) {
		if (removeTuioCursor!=null) {
			try { 
				removeTuioCursor.invoke(parent, new Object[] { tcur });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}

	public void addTuioBlob(TuioBlob tblb) {
		if (addTuioBlob!=null) {
			try { 
				addTuioBlob.invoke(parent, new Object[] { tblb });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public void updateTuioBlob(TuioBlob tblb) {
		if (updateTuioBlob!=null) {
			try { 
				updateTuioBlob.invoke(parent, new Object[] { tblb });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public void removeTuioBlob(TuioBlob tblb) {
		if (removeTuioBlob!=null) {
			try { 
				removeTuioBlob.invoke(parent, new Object[] { tblb });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public void refresh(TuioTime bundleTime) {
		if (refresh!=null) {
			try { 
				refresh.invoke(parent,new Object[] { bundleTime });
			}
			catch (IllegalAccessException e) {}
			catch (IllegalArgumentException e) {}
			catch (InvocationTargetException e) {}
		}
	}
	
	public ArrayList<TuioObject> getTuioObjectList() {
		return client.getTuioObjectList();
	}
	
	public ArrayList<TuioCursor> getTuioCursorList() {
		return client.getTuioCursorList();
	}	
	
	public ArrayList<TuioBlob> getTuioBlobList() {
		return client.getTuioBlobList();
	}	
	
	public TuioObject getTuioObject(long s_id) {
		return client.getTuioObject(s_id);
	}
	
	public TuioCursor getTuioCursor(long s_id) {
		return client.getTuioCursor(s_id);
	}	

	public TuioBlob getTuioBlob(long s_id) {
		return client.getTuioBlob(s_id);
	}	
	
	public void pre() {
		//method that's called just after beginFrame(), meaning that it 
		//can affect drawing.
	}

	public void draw() {
		//method that's called at the end of draw(), but before endFrame().
	}
	
	public void mouseEvent(MouseEvent e) {
		//called when a mouse event occurs in the parent applet
	}
	
	public void keyEvent(KeyEvent e) {
		//called when a key event occurs in the parent applet
	}
	
	public void post() {
		//method called after draw has completed and the frame is done.
		//no drawing allowed.
	}
	
	public void size(int width, int height) {
		//this will be called the first time an applet sets its size, but
		//also any time that it's called while the PApplet is running.
	}
	
	public void stop() {
		//can be called by users, for instance movie.stop() will shut down
		//a movie that's being played, or camera.stop() stops capturing 
		//video. server.stop() will shut down the server and shut it down
		//completely, which is identical to its "dispose" function.
	}
	
	public void dispose() {
	
		if (client.isConnected()) client.disconnect();
	
		//this should only be called by PApplet. dispose() is what gets 
		//called when the host applet is stopped, so this should shut down
		//any threads, disconnect from the net, unload memory, etc. 
	}
}
