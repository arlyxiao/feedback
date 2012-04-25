class ProblemTypesController < ApplicationController
  # GET /problem_types
  # GET /problem_types.json
  def index
    @problem_types = ProblemType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @problem_types }
    end
  end

  # GET /problem_types/1
  # GET /problem_types/1.json
  def show
    @problem_type = ProblemType.find(params[:id])
    @problem_fields = @problem_type.problem_fields

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @problem_fields }
      format.json { render :json => @problem_type }
    end
  end

  # GET /problem_types/new
  # GET /problem_types/new.json
  def new
    @problem_type = ProblemType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @problem_type }
    end
  end

  # GET /problem_types/1/edit
  def edit
    @problem_type = ProblemType.find(params[:id])
  end

  # POST /problem_types
  # POST /problem_types.json
  def create
    @problem_type = current_user.problem_types.build(params[:problem_type])

    respond_to do |format|
      if @problem_type.save
        format.html { redirect_to @problem_type, :notice => 'Problem type was successfully created.' }
        format.json { render :json => @problem_type, :status => :created, :location => @problem_type }
      else
        format.html { render :action => "new" }
        format.json { render :json => @problem_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /problem_types/1
  # PUT /problem_types/1.json
  def update
    @problem_type = ProblemType.find(params[:id])

    respond_to do |format|
      if @problem_type.update_attributes(params[:problem_type])
        format.html { redirect_to @problem_type, :notice => 'Problem type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @problem_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_types/1
  # DELETE /problem_types/1.json
  def destroy
    @problem_type = ProblemType.find(params[:id])
    @problem_type.destroy

    respond_to do |format|
      format.html { redirect_to problem_types_url }
      format.json { head :ok }
    end
  end
  
  def export_to_xml
    @problem_type = ProblemType.find(params[:id])
    @entries = @problem_type.problem_fields

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root {
        xml.objects {
          @entries.each do |o|
            xml.object(
              :problem_type_id => o.problem_type_id, 
              :name => o.name, 
              :field_type => o.field_type
            )
          end
        }
      }
    end
    
    send_data builder.to_xml,
      :type => 'text/xml; charset=UTF-8;',
      :disposition => "attachment; filename=entries.xml"
  end
  
  def import_from_xml
    xmlfile = params[:xmlfile]
    if xmlfile.respond_to?(:read)
      xml_contents = xmlfile.read
    else xmlfile.respond_to?(:path)
      xml_contents = File.read(xmlfile.path)
    end
    
    xml = Nokogiri::XML(xml_contents)
    xml.xpath('//root/objects/object').each do |node|
      ProblemField.create(
        :name => node['name'],
        :problem_type_id => node['problem_type_id'],
        :field_type => node['field_type']
      )
    end
    
    redirect_to :back
    
  end
  
end
