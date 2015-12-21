# AJAX Reminder App
1. Mark the link to be a remote link so that rails understands it to be async.

        <%= link_to cat.name, fetch_items_path(:id => cat.id), :remote => true %>
        
2. Set up a route to handle the incoming request and parameters. Good to name it. 

        get '/fetch_items' => 'items#from_category', as: 'fetch_items'
        
3. Build an action to handle and process the meaty part of the method. It's necessary to
include a `respond_to` block so as to set-up the javascript file that will incorporate 
the returned data into the DOM.

        #ItemsController...
        
        def from_category
            @selected = Item.where(:category_id => params[:id])
            @parent_id = params[:id]
       
            respond_to do |format|
                format.js 
            end
        end
        
4. Set up the js.erb file that will provide the view for the JS formatted request response
data. This will also handle the tadk of weaving the response into the final AJAXed page.

        $('#<%= @parent_id %>').after(
            "<%= escape_javascript(render partial: 'items_list', locals: { items: @selected }) %>"
        );
        
