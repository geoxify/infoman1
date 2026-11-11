import os
import math
from PIL import Image, ImageDraw, ImageFont

OUTPUT_DIR = r"c:\Users\geo\Desktop\Master Personal Folder\School\INFOMAN!\infoman1\prelim"
os.makedirs(OUTPUT_DIR, exist_ok=True)

# -----------------------------------------------------------------------------
# 1. TASK 1: CONCEPTUAL ERD (.drawio XML)
# -----------------------------------------------------------------------------
def generate_task1_drawio():
    xml_content = """<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net" modified="2026-11-11T14:50:00.000Z" agent="Antigravity" version="21.6.8" type="device">
  <diagram id="task1-conceptual-erd" name="Task 1 Conceptual ERD">
    <mxGraphModel dx="1200" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1300" pageHeight="850" background="#ffffff" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title Block -->
        <mxCell id="title" value="ToolShare — Conceptual ERD (Task 1)&#xa;Course: INFOMAN1 | Student: Geoff Benedict Cariño (ID: 2511028)" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=18;fontStyle=1;fontColor=#1a237e;" vertex="1" parent="1">
          <mxGeometry x="350" y="20" width="600" height="40" as="geometry" />
        </mxCell>

        <!-- ENTITY: MEMBER -->
        <mxCell id="ent_member" value="MEMBER" style="rounded=1;whiteSpace=wrap;html=1;fontSize=16;fontStyle=1;fillColor=#d2e3fc;strokeColor=#185abc;strokeWidth=2;fontColor=#0d47a1;" vertex="1" parent="1">
          <mxGeometry x="100" y="220" width="160" height="70" as="geometry" />
        </mxCell>
        <!-- Member Attributes -->
        <mxCell id="attr_m1" value="&lt;u&gt;member_id&lt;/u&gt; (PK)" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fontStyle=1;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="30" y="110" width="130" height="45" as="geometry" />
        </mxCell>
        <mxCell id="edge_m1" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_m1" target="ent_member">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="attr_m2" value="member_name" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="190" y="110" width="120" height="45" as="geometry" />
        </mxCell>
        <mxCell id="edge_m2" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_m2" target="ent_member">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="attr_m3" value="phone" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="10" y="290" width="100" height="40" as="geometry" />
        </mxCell>
        <mxCell id="edge_m3" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_m3" target="ent_member">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="attr_m4" value="join_date" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="10" y="210" width="100" height="40" as="geometry" />
        </mxCell>
        <mxCell id="edge_m4" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_m4" target="ent_member">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- ENTITY: TOOL -->
        <mxCell id="ent_tool" value="TOOL" style="rounded=1;whiteSpace=wrap;html=1;fontSize=16;fontStyle=1;fillColor=#d2e3fc;strokeColor=#185abc;strokeWidth=2;fontColor=#0d47a1;" vertex="1" parent="1">
          <mxGeometry x="720" y="220" width="160" height="70" as="geometry" />
        </mxCell>
        <!-- Tool Attributes -->
        <mxCell id="attr_t1" value="&lt;u&gt;tool_id&lt;/u&gt; (PK)" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fontStyle=1;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="680" y="110" width="110" height="45" as="geometry" />
        </mxCell>
        <mxCell id="edge_t1" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_t1" target="ent_tool">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="attr_t2" value="tool_name" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="810" y="110" width="110" height="45" as="geometry" />
        </mxCell>
        <mxCell id="edge_t2" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_t2" target="ent_tool">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="attr_t3" value="category" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="900" y="190" width="100" height="40" as="geometry" />
        </mxCell>
        <mxCell id="edge_t3" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_t3" target="ent_tool">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="attr_t4" value="purchase_date" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="900" y="270" width="110" height="40" as="geometry" />
        </mxCell>
        <mxCell id="edge_t4" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_t4" target="ent_tool">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- ENTITY: STORAGE LOCATION -->
        <mxCell id="ent_location" value="STORAGE LOCATION" style="rounded=1;whiteSpace=wrap;html=1;fontSize=16;fontStyle=1;fillColor=#d2e3fc;strokeColor=#185abc;strokeWidth=2;fontColor=#0d47a1;" vertex="1" parent="1">
          <mxGeometry x="1040" y="480" width="190" height="70" as="geometry" />
        </mxCell>
        <!-- Location Attributes -->
        <mxCell id="attr_l1" value="&lt;u&gt;location_code&lt;/u&gt; (PK)" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fontStyle=1;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="990" y="600" width="140" height="45" as="geometry" />
        </mxCell>
        <mxCell id="edge_l1" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_l1" target="ent_location">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="attr_l2" value="description" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="1150" y="600" width="110" height="45" as="geometry" />
        </mxCell>
        <mxCell id="edge_l2" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_l2" target="ent_location">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- ENTITY: CERTIFICATION -->
        <mxCell id="ent_cert" value="CERTIFICATION" style="rounded=1;whiteSpace=wrap;html=1;fontSize=16;fontStyle=1;fillColor=#d2e3fc;strokeColor=#185abc;strokeWidth=2;fontColor=#0d47a1;" vertex="1" parent="1">
          <mxGeometry x="410" y="660" width="170" height="70" as="geometry" />
        </mxCell>
        <!-- Certification Attributes -->
        <mxCell id="attr_c1" value="&lt;u&gt;cert_id&lt;/u&gt; (PK)" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fontStyle=1;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="360" y="770" width="110" height="45" as="geometry" />
        </mxCell>
        <mxCell id="edge_c1" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_c1" target="ent_cert">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="attr_c2" value="cert_name" style="ellipse;whiteSpace=wrap;html=1;fontSize=12;fillColor=#ffffff;strokeColor=#185abc;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="490" y="770" width="120" height="45" as="geometry" />
        </mxCell>
        <mxCell id="edge_c2" style="endArrow=none;html=1;strokeColor=#185abc;strokeWidth=1.5;" edge="1" parent="1" source="attr_c2" target="ent_cert">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- RELATIONSHIP 1: MEMBER - TOOL (borrows) [M:N] -->
        <mxCell id="rel_borrow" value="borrows" style="rhombus;whiteSpace=wrap;html=1;fontSize=14;fontStyle=1;fillColor=#feefe3;strokeColor=#ea8600;strokeWidth=2;fontColor=#b06000;" vertex="1" parent="1">
          <mxGeometry x="420" y="215" width="140" height="80" as="geometry" />
        </mxCell>
        <!-- Relationship Attributes for borrows -->
        <mxCell id="attr_b1" value="borrow_date" style="ellipse;whiteSpace=wrap;html=1;fontSize=11;fillColor=#ffffff;strokeColor=#ea8600;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="400" y="140" width="90" height="35" as="geometry" />
        </mxCell>
        <mxCell id="edge_b1" style="endArrow=none;html=1;dashed=1;strokeColor=#ea8600;strokeWidth=1;" edge="1" parent="1" source="attr_b1" target="rel_borrow">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="attr_b2" value="return_date (null)" style="ellipse;whiteSpace=wrap;html=1;fontSize=11;fillColor=#ffffff;strokeColor=#ea8600;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="500" y="140" width="110" height="35" as="geometry" />
        </mxCell>
        <mxCell id="edge_b2" style="endArrow=none;html=1;dashed=1;strokeColor=#ea8600;strokeWidth=1;" edge="1" parent="1" source="attr_b2" target="rel_borrow">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Connect Member <-> borrows <-> Tool (M:N) -->
        <mxCell id="edge_m_borrow" style="endArrow=ERzeroToMany;html=1;strokeColor=#202124;strokeWidth=2;exitX=1;exitY=0.5;exitDx=0;exitDy=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" edge="1" parent="1" source="ent_member" target="rel_borrow">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="edge_borrow_t" style="endArrow=ERzeroToMany;html=1;strokeColor=#202124;strokeWidth=2;exitX=1;exitY=0.5;exitDx=0;exitDy=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" edge="1" parent="1" source="rel_borrow" target="ent_tool">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_m_borrow" value="0..N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=12;fontStyle=1;fontColor=#202124;" vertex="1" connectable="0" parent="edge_m_borrow">
          <mxGeometry x="-0.3" y="15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>
        <mxCell id="lbl_borrow_t" value="0..N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=12;fontStyle=1;fontColor=#202124;" vertex="1" connectable="0" parent="edge_borrow_t">
          <mxGeometry x="0.3" y="15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- RELATIONSHIP 2: MEMBER - CERTIFICATION (completes) [M:N] -->
        <mxCell id="rel_complete" value="completes" style="rhombus;whiteSpace=wrap;html=1;fontSize=14;fontStyle=1;fillColor=#feefe3;strokeColor=#ea8600;strokeWidth=2;fontColor=#b06000;" vertex="1" parent="1">
          <mxGeometry x="170" y="470" width="140" height="80" as="geometry" />
        </mxCell>
        <mxCell id="attr_comp_date" value="completion_date" style="ellipse;whiteSpace=wrap;html=1;fontSize=11;fillColor=#ffffff;strokeColor=#ea8600;strokeWidth=1.5;" vertex="1" parent="1">
          <mxGeometry x="80" y="560" width="110" height="35" as="geometry" />
        </mxCell>
        <mxCell id="edge_comp_date" style="endArrow=none;html=1;dashed=1;strokeColor=#ea8600;strokeWidth=1;" edge="1" parent="1" source="attr_comp_date" target="rel_complete">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="edge_m_comp" style="endArrow=ERzeroToMany;html=1;strokeColor=#202124;strokeWidth=2;exitX=0.5;exitY=1;exitDx=0;exitDy=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;" edge="1" parent="1" source="ent_member" target="rel_complete">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="edge_comp_c" style="endArrow=ERzeroToMany;html=1;strokeColor=#202124;strokeWidth=2;exitX=1;exitY=1;exitDx=0;exitDy=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" edge="1" parent="1" source="rel_complete" target="ent_cert">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_m_comp" value="0..N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=12;fontStyle=1;" vertex="1" connectable="0" parent="edge_m_comp">
          <mxGeometry x="-0.2" y="-15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>
        <mxCell id="lbl_comp_c" value="0..N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=12;fontStyle=1;" vertex="1" connectable="0" parent="edge_comp_c">
          <mxGeometry x="0.2" y="15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- RELATIONSHIP 3: TOOL - CERTIFICATION (requires) [M:N] -->
        <mxCell id="rel_require" value="requires" style="rhombus;whiteSpace=wrap;html=1;fontSize=14;fontStyle=1;fillColor=#feefe3;strokeColor=#ea8600;strokeWidth=2;fontColor=#b06000;" vertex="1" parent="1">
          <mxGeometry x="630" y="470" width="140" height="80" as="geometry" />
        </mxCell>
        <mxCell id="edge_t_req" style="endArrow=ERzeroToMany;html=1;strokeColor=#202124;strokeWidth=2;exitX=0.5;exitY=1;exitDx=0;exitDy=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;" edge="1" parent="1" source="ent_tool" target="rel_require">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="edge_req_c" style="endArrow=ERzeroToMany;html=1;strokeColor=#202124;strokeWidth=2;exitX=0;exitY=1;exitDx=0;exitDy=0;entryX=1;entryY=0.5;entryDx=0;entryDy=0;" edge="1" parent="1" source="rel_require" target="ent_cert">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_t_req" value="0..N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=12;fontStyle=1;" vertex="1" connectable="0" parent="edge_t_req">
          <mxGeometry x="-0.2" y="15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>
        <mxCell id="lbl_req_c" value="0..N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=12;fontStyle=1;" vertex="1" connectable="0" parent="edge_req_c">
          <mxGeometry x="0.2" y="-15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- RELATIONSHIP 4: STORAGE LOCATION - TOOL (houses) [1:N] -->
        <mxCell id="rel_houses" value="houses" style="rhombus;whiteSpace=wrap;html=1;fontSize=14;fontStyle=1;fillColor=#feefe3;strokeColor=#ea8600;strokeWidth=2;fontColor=#b06000;" vertex="1" parent="1">
          <mxGeometry x="920" y="380" width="130" height="70" as="geometry" />
        </mxCell>
        <mxCell id="edge_loc_houses" style="endArrow=ERmandOne;html=1;strokeColor=#202124;strokeWidth=2;exitX=0.5;exitY=0;exitDx=0;exitDy=0;entryX=1;entryY=0.5;entryDx=0;entryDy=0;" edge="1" parent="1" source="ent_location" target="rel_houses">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="edge_houses_tool" style="endArrow=ERzeroToMany;html=1;strokeColor=#202124;strokeWidth=2;exitX=0;exitY=0.5;exitDx=0;exitDy=0;entryX=0.75;entryY=1;entryDx=0;entryDy=0;" edge="1" parent="1" source="rel_houses" target="ent_tool">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_loc_houses" value="1..1 (Mandatory)" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;" vertex="1" connectable="0" parent="edge_loc_houses">
          <mxGeometry x="-0.2" y="-15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>
        <mxCell id="lbl_houses_tool" value="0..N (Optional)" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;" vertex="1" connectable="0" parent="edge_houses_tool">
          <mxGeometry x="0.2" y="15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- Cardinality Legend Box -->
        <mxCell id="legend_box" value="&lt;b&gt;Cardinality &amp;amp; Participation Legend&lt;/b&gt;&#xa;• 1..1 : Exactly one (Mandatory total participation)&#xa;• 0..N : Zero or many (Optional participation)&#xa;• Pure Conceptual ERD (No M:N resolved yet)" style="rounded=1;whiteSpace=wrap;html=1;fontSize=11;align=left;fillColor=#f8f9fa;strokeColor=#dadce0;strokeWidth=1;" vertex="1" parent="1">
          <mxGeometry x="720" y="650" width="280" height="80" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>"""
    out_path = os.path.join(OUTPUT_DIR, "task1_conceptual_erd.drawio")
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(xml_content)
    print("Generated task1_conceptual_erd.drawio")

# -----------------------------------------------------------------------------
# 2. TASK 2: LOGICAL ERD (.drawio XML)
# -----------------------------------------------------------------------------
def generate_task2_drawio():
    xml_content = """<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net" modified="2026-11-11T14:50:00.000Z" agent="Antigravity" version="21.6.8" type="device">
  <diagram id="task2-logical-erd" name="Task 2 Logical ERD">
    <mxGraphModel dx="1200" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="900" background="#ffffff" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title Block -->
        <mxCell id="title" value="ToolShare — Logical ERD &amp; Relational Entities (Task 2)&#xa;Course: INFOMAN1 | Student: Geoff Benedict Cariño (ID: 2511028)" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=18;fontStyle=1;fontColor=#1a237e;" vertex="1" parent="1">
          <mxGeometry x="400" y="20" width="600" height="40" as="geometry" />
        </mxCell>

        <!-- TABLE: storage_location -->
        <mxCell id="tbl_storage" value="storage_location&#xa;&lt;hr&gt;&lt;u&gt;location_code&lt;/u&gt; : VARCHAR(10) [PK]&#xa;description : VARCHAR(100)" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;html=1;fontSize=13;fillColor=#e8f0fe;strokeColor=#1a73e8;strokeWidth=2;" vertex="1" parent="1">
          <mxGeometry x="1000" y="100" width="220" height="90" as="geometry" />
        </mxCell>

        <!-- TABLE: tool -->
        <mxCell id="tbl_tool" value="tool&#xa;&lt;hr&gt;&lt;u&gt;tool_id&lt;/u&gt; : INT [PK]&#xa;tool_name : VARCHAR(100)&#xa;category : VARCHAR(50)&#xa;purchase_date : DATE&#xa;location_code : VARCHAR(10) [FK]" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;html=1;fontSize=13;fillColor=#e8f0fe;strokeColor=#1a73e8;strokeWidth=2;" vertex="1" parent="1">
          <mxGeometry x="700" y="280" width="230" height="140" as="geometry" />
        </mxCell>

        <!-- TABLE: member -->
        <mxCell id="tbl_member" value="member&#xa;&lt;hr&gt;&lt;u&gt;member_id&lt;/u&gt; : INT [PK]&#xa;member_name : VARCHAR(100)&#xa;phone : VARCHAR(20)&#xa;join_date : DATE" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;html=1;fontSize=13;fillColor=#e8f0fe;strokeColor=#1a73e8;strokeWidth=2;" vertex="1" parent="1">
          <mxGeometry x="80" y="280" width="220" height="120" as="geometry" />
        </mxCell>

        <!-- JUNCTION TABLE: borrowing (resolves member <-> tool) -->
        <mxCell id="tbl_borrowing" value="borrowing&#xa;&lt;hr&gt;&lt;u&gt;borrow_id&lt;/u&gt; : INT [PK]&#xa;member_id : INT [FK]&#xa;tool_id : INT [FK]&#xa;borrow_date : DATE&#xa;return_date : DATE (NULL)" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;html=1;fontSize=13;fillColor=#fef7e0;strokeColor=#f9ab00;strokeWidth=2;" vertex="1" parent="1">
          <mxGeometry x="390" y="270" width="220" height="150" as="geometry" />
        </mxCell>

        <!-- TABLE: certification -->
        <mxCell id="tbl_cert" value="certification&#xa;&lt;hr&gt;&lt;u&gt;cert_id&lt;/u&gt; : INT [PK]&#xa;cert_name : VARCHAR(100)" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;html=1;fontSize=13;fillColor=#e8f0fe;strokeColor=#1a73e8;strokeWidth=2;" vertex="1" parent="1">
          <mxGeometry x="540" y="680" width="210" height="85" as="geometry" />
        </mxCell>

        <!-- JUNCTION TABLE: member_certification (resolves member <-> cert) -->
        <mxCell id="tbl_mem_cert" value="member_certification&#xa;&lt;hr&gt;&lt;u&gt;member_id&lt;/u&gt; : INT [PK, FK]&#xa;&lt;u&gt;cert_id&lt;/u&gt; : INT [PK, FK]&#xa;completion_date : DATE" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;html=1;fontSize=13;fillColor=#fef7e0;strokeColor=#f9ab00;strokeWidth=2;" vertex="1" parent="1">
          <mxGeometry x="160" y="520" width="230" height="110" as="geometry" />
        </mxCell>

        <!-- JUNCTION TABLE: tool_requirement (resolves tool <-> cert) -->
        <mxCell id="tbl_tool_req" value="tool_requirement&#xa;&lt;hr&gt;&lt;u&gt;tool_id&lt;/u&gt; : INT [PK, FK]&#xa;&lt;u&gt;cert_id&lt;/u&gt; : INT [PK, FK]" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;html=1;fontSize=13;fillColor=#fef7e0;strokeColor=#f9ab00;strokeWidth=2;" vertex="1" parent="1">
          <mxGeometry x="880" y="520" width="220" height="95" as="geometry" />
        </mxCell>

        <!-- RELATIONSHIP LINES (Crow's foot) -->

        <!-- 1. storage_location (1) to tool (N) -->
        <mxCell id="edge_sl_tool" style="endArrow=ERmandOne;startArrow=ERzeroToMany;html=1;strokeColor=#1a73e8;strokeWidth=2;exitX=0.5;exitY=0;exitDx=0;exitDy=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" edge="1" parent="1" source="tbl_tool" target="tbl_storage">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_sl_tool" value="1 : N&#xa;(location_code FK)" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;fontColor=#1a73e8;" vertex="1" connectable="0" parent="edge_sl_tool">
          <mxGeometry x="-0.2" y="-15" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- 2. member (1) to borrowing (N) -->
        <mxCell id="edge_m_b" style="startArrow=ERmandOne;endArrow=ERzeroToMany;html=1;strokeColor=#f29900;strokeWidth=2;exitX=1;exitY=0.5;exitDx=0;exitDy=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" edge="1" parent="1" source="tbl_member" target="tbl_borrowing">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_m_b" value="1 : N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;" vertex="1" connectable="0" parent="edge_m_b">
          <mxGeometry x="0" y="-12" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- 3. tool (1) to borrowing (N) -->
        <mxCell id="edge_t_b" style="startArrow=ERmandOne;endArrow=ERzeroToMany;html=1;strokeColor=#f29900;strokeWidth=2;exitX=0;exitY=0.5;exitDx=0;exitDy=0;entryX=1;entryY=0.5;entryDx=0;entryDy=0;" edge="1" parent="1" source="tbl_tool" target="tbl_borrowing">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_t_b" value="1 : N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;" vertex="1" connectable="0" parent="edge_t_b">
          <mxGeometry x="0" y="-12" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- 4. member (1) to member_certification (N) -->
        <mxCell id="edge_m_mc" style="startArrow=ERmandOne;endArrow=ERzeroToMany;html=1;strokeColor=#f29900;strokeWidth=2;exitX=0.5;exitY=1;exitDx=0;exitDy=0;entryX=0.25;entryY=0;entryDx=0;entryDy=0;" edge="1" parent="1" source="tbl_member" target="tbl_mem_cert">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_m_mc" value="1 : N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;" vertex="1" connectable="0" parent="edge_m_mc">
          <mxGeometry x="-0.2" y="10" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- 5. certification (1) to member_certification (N) -->
        <mxCell id="edge_c_mc" style="startArrow=ERmandOne;endArrow=ERzeroToMany;html=1;strokeColor=#f29900;strokeWidth=2;exitX=0;exitY=0.5;exitDx=0;exitDy=0;entryX=0.75;entryY=1;entryDx=0;entryDy=0;" edge="1" parent="1" source="tbl_cert" target="tbl_mem_cert">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_c_mc" value="1 : N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;" vertex="1" connectable="0" parent="edge_c_mc">
          <mxGeometry x="0" y="12" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- 6. tool (1) to tool_requirement (N) -->
        <mxCell id="edge_t_tr" style="startArrow=ERmandOne;endArrow=ERzeroToMany;html=1;strokeColor=#f29900;strokeWidth=2;exitX=0.75;exitY=1;exitDx=0;exitDy=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;" edge="1" parent="1" source="tbl_tool" target="tbl_tool_req">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_t_tr" value="1 : N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;" vertex="1" connectable="0" parent="edge_t_tr">
          <mxGeometry x="-0.2" y="-12" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- 7. certification (1) to tool_requirement (N) -->
        <mxCell id="edge_c_tr" style="startArrow=ERmandOne;endArrow=ERzeroToMany;html=1;strokeColor=#f29900;strokeWidth=2;exitX=1;exitY=0.5;exitDx=0;exitDy=0;entryX=0.5;entryY=1;entryDx=0;entryDy=0;" edge="1" parent="1" source="tbl_cert" target="tbl_tool_req">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="lbl_c_tr" value="1 : N" style="edgeLabel;html=1;align=center;verticalAlign=middle;resizable=0;points=[];fontSize=11;fontStyle=1;" vertex="1" connectable="0" parent="edge_c_tr">
          <mxGeometry x="0" y="12" relative="1" as="geometry"><mxPoint as="offset" /></mxGeometry>
        </mxCell>

        <!-- Legend Box -->
        <mxCell id="legend_box2" value="&lt;b&gt;Logical Relational Translation Legend&lt;/b&gt;&#xa;• Blue tables = Core Strong Entities&#xa;• Yellow tables = Junction / Associative Entities (M:N resolved)&#xa;• &lt;u&gt;Underlined&lt;/u&gt; = Primary Key (PK)&#xa;• [FK] = Foreign Key reference to parent table" style="rounded=1;whiteSpace=wrap;html=1;fontSize=11;align=left;fillColor=#f8f9fa;strokeColor=#dadce0;strokeWidth=1;" vertex="1" parent="1">
          <mxGeometry x="495" y="470" width="300" height="90" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>"""
    out_path = os.path.join(OUTPUT_DIR, "task2_logical_erd.drawio")
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(xml_content)
    print("Generated task2_logical_erd.drawio")

# -----------------------------------------------------------------------------
# 3. HIGH-RES PNG RENDERING (PILLOW)
# -----------------------------------------------------------------------------
def get_fonts():
    bold_path = r"C:\Windows\Fonts\segoeuib.ttf" if os.path.exists(r"C:\Windows\Fonts\segoeuib.ttf") else r"C:\Windows\Fonts\arialbd.ttf"
    regular_path = r"C:\Windows\Fonts\segoeui.ttf" if os.path.exists(r"C:\Windows\Fonts\segoeui.ttf") else r"C:\Windows\Fonts\arial.ttf"
    
    return {
        "title": ImageFont.truetype(bold_path, 22),
        "subtitle": ImageFont.truetype(regular_path, 14),
        "entity_header": ImageFont.truetype(bold_path, 15),
        "body_bold": ImageFont.truetype(bold_path, 12),
        "body": ImageFont.truetype(regular_path, 12),
        "small": ImageFont.truetype(regular_path, 11),
        "cardinality": ImageFont.truetype(bold_path, 12)
    }

fonts = get_fonts()

def render_task1_png():
    width, height = 1350, 900
    img = Image.new("RGB", (width, height), (255, 255, 255))
    draw = ImageDraw.Draw(img)

    for x in range(0, width, 40):
        for y in range(0, height, 40):
            draw.point((x, y), fill=(240, 243, 246))

    draw.rounded_rectangle([40, 20, width - 40, 85], radius=8, fill=(245, 248, 255), outline=(200, 215, 245), width=1)
    draw.text((60, 30), "ToolShare — Conceptual ERD (Task 1)", fill=(24, 43, 73), font=fonts["title"])
    draw.text((60, 58), "Course: INFOMAN1 | Student: Geoff Benedict P. Cariño (ID: 2511028) | Coverage: Weeks 1–2", fill=(80, 100, 130), font=fonts["subtitle"])

    def draw_diamond(center, radius_x, radius_y, text, fill=(254, 239, 227), outline=(234, 134, 0)):
        cx, cy = center
        pts = [(cx, cy - radius_y), (cx + radius_x, cy), (cx, cy + radius_y), (cx - radius_x, cy)]
        draw.polygon(pts, fill=fill, outline=outline)
        bbox = draw.textbbox((0, 0), text, font=fonts["entity_header"])
        tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
        draw.text((cx - tw / 2, cy - th / 2), text, fill=(176, 96, 0), font=fonts["entity_header"])

    def draw_entity(x1, y1, x2, y2, name, fill=(210, 227, 252), outline=(24, 90, 188)):
        draw.rounded_rectangle([x1, y1, x2, y2], radius=6, fill=fill, outline=outline, width=2)
        bbox = draw.textbbox((0, 0), name, font=fonts["entity_header"])
        tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
        draw.text(((x1 + x2) / 2 - tw / 2, (y1 + y2) / 2 - th / 2), name, fill=(13, 71, 161), font=fonts["entity_header"])

    def draw_attr(cx, cy, rx, ry, name, is_pk=False, is_dashed=False):
        bbox = [cx - rx, cy - ry, cx + rx, cy + ry]
        draw.ellipse(bbox, fill=(255, 255, 255), outline=(24, 90, 188) if not is_dashed else (234, 134, 0), width=1)
        font = fonts["body_bold"] if is_pk else fonts["body"]
        color = (13, 71, 161) if not is_dashed else (176, 96, 0)
        tbox = draw.textbbox((0, 0), name, font=font)
        tw, th = tbox[2] - tbox[0], tbox[3] - tbox[1]
        draw.text((cx - tw / 2, cy - th / 2), name, fill=color, font=font)
        if is_pk:
            uy = cy + th / 2 + 1
            draw.line([(cx - tw / 2, uy), (cx + tw / 2, uy)], fill=color, width=1)

    # 1. ENTITY: MEMBER
    draw_entity(120, 240, 280, 310, "MEMBER")
    attrs_m = [
        (80, 150, 65, 20, "member_id (PK)", True),
        (230, 150, 60, 20, "member_name", False),
        (50, 240, 45, 18, "join_date", False),
        (50, 310, 40, 18, "phone", False),
    ]
    for cx, cy, rx, ry, name, pk in attrs_m:
        draw.line([(cx, cy), (200, 275)], fill=(150, 180, 220), width=1)
        draw_attr(cx, cy, rx, ry, name, is_pk=pk)

    # 2. ENTITY: TOOL
    draw_entity(740, 240, 900, 310, "TOOL")
    attrs_t = [
        (730, 150, 55, 20, "tool_id (PK)", True),
        (870, 150, 55, 20, "tool_name", False),
        (980, 240, 50, 18, "category", False),
        (980, 310, 65, 18, "purchase_date", False),
    ]
    for cx, cy, rx, ry, name, pk in attrs_t:
        draw.line([(cx, cy), (820, 275)], fill=(150, 180, 220), width=1)
        draw_attr(cx, cy, rx, ry, name, is_pk=pk)

    # 3. ENTITY: CERTIFICATION
    draw_entity(430, 690, 590, 760, "CERTIFICATION")
    attrs_c = [
        (430, 810, 55, 20, "cert_id (PK)", True),
        (580, 810, 55, 20, "cert_name", False),
    ]
    for cx, cy, rx, ry, name, pk in attrs_c:
        draw.line([(cx, cy), (510, 725)], fill=(150, 180, 220), width=1)
        draw_attr(cx, cy, rx, ry, name, is_pk=pk)

    # 4. ENTITY: STORAGE LOCATION
    draw_entity(1040, 500, 1260, 570, "STORAGE LOCATION")
    attrs_l = [
        (1050, 630, 75, 20, "location_code (PK)", True),
        (1220, 630, 60, 20, "description", False),
    ]
    for cx, cy, rx, ry, name, pk in attrs_l:
        draw.line([(cx, cy), (1150, 535)], fill=(150, 180, 220), width=1)
        draw_attr(cx, cy, rx, ry, name, is_pk=pk)

    # RELATIONSHIPS
    # borrows (M:N)
    draw_diamond((510, 275), 75, 45, "borrows")
    draw.line([(280, 275), (435, 275)], fill=(40, 40, 40), width=2)
    draw.line([(585, 275), (740, 275)], fill=(40, 40, 40), width=2)
    draw.text((300, 250), "0..N (Optional)", fill=(24, 90, 188), font=fonts["cardinality"])
    draw.text((640, 250), "0..N (Optional)", fill=(24, 90, 188), font=fonts["cardinality"])
    draw.line([(450, 180), (510, 230)], fill=(234, 134, 0), width=1)
    draw.line([(570, 180), (510, 230)], fill=(234, 134, 0), width=1)
    draw_attr(450, 180, 55, 18, "borrow_date", is_dashed=True)
    draw_attr(570, 180, 60, 18, "return_date (null)", is_dashed=True)

    # completes (M:N)
    draw_diamond((200, 520), 75, 45, "completes")
    draw.line([(200, 310), (200, 475)], fill=(40, 40, 40), width=2)
    draw.line([(200, 565), (200, 725), (430, 725)], fill=(40, 40, 40), width=2)
    draw.text((210, 330), "0..N", fill=(24, 90, 188), font=fonts["cardinality"])
    draw.text((370, 705), "0..N", fill=(24, 90, 188), font=fonts["cardinality"])
    draw.line([(100, 590), (145, 545)], fill=(234, 134, 0), width=1)
    draw_attr(100, 590, 65, 18, "completion_date", is_dashed=True)

    # requires (M:N)
    draw_diamond((670, 520), 75, 45, "requires")
    draw.line([(820, 310), (820, 520), (745, 520)], fill=(40, 40, 40), width=2)
    draw.line([(595, 520), (510, 520), (510, 690)], fill=(40, 40, 40), width=2)
    draw.text((825, 330), "0..N", fill=(24, 90, 188), font=fonts["cardinality"])
    draw.text((515, 665), "0..N", fill=(24, 90, 188), font=fonts["cardinality"])

    # houses (1:N)
    draw_diamond((980, 400), 70, 40, "houses")
    draw.line([(1150, 500), (1150, 400), (1050, 400)], fill=(40, 40, 40), width=2)
    draw.line([(910, 400), (820, 400), (820, 310)], fill=(40, 40, 40), width=2)
    draw.text((1155, 470), "0..N (Can hold 0 or more)", fill=(24, 90, 188), font=fonts["cardinality"])
    draw.text((825, 380), "1..1 (Mandatory - Total Participation)", fill=(190, 30, 30), font=fonts["cardinality"])

    # Legend Card
    draw.rounded_rectangle([750, 680, 1260, 830], radius=8, fill=(248, 249, 250), outline=(218, 220, 224), width=1)
    draw.text((770, 695), "Conceptual ERD Notation & Rules (Week 1–2):", fill=(32, 33, 36), font=fonts["entity_header"])
    draw.text((770, 725), "• Rectangles: Core Entities (Member, Tool, Storage Location, Certification)", fill=(60, 64, 67), font=fonts["small"])
    draw.text((770, 745), "• Diamonds: Relationships with active verb phrases (borrows, completes, requires, houses)", fill=(60, 64, 67), font=fonts["small"])
    draw.text((770, 765), "• Ovals: Entity & Relationship attributes (Underlined = Primary Key; Dashed = Relationship attr)", fill=(60, 64, 67), font=fonts["small"])
    draw.text((770, 785), "• 1..1 : Mandatory Total Participation | 0..N : Optional Multiple Cardinality", fill=(60, 64, 67), font=fonts["small"])
    draw.text((770, 805), "• Pure Conceptual ERD: All M:N relationships remain un-resolved per acceptance criteria", fill=(190, 60, 0), font=fonts["body_bold"])

    out_file = os.path.join(OUTPUT_DIR, "task1_conceptual_erd.png")
    img.save(out_file, "PNG")
    print("Generated task1_conceptual_erd.png")

def render_task2_png():
    width, height = 1450, 960
    img = Image.new("RGB", (width, height), (255, 255, 255))
    draw = ImageDraw.Draw(img)

    for x in range(0, width, 40):
        for y in range(0, height, 40):
            draw.point((x, y), fill=(240, 243, 246))

    draw.rounded_rectangle([40, 20, width - 40, 85], radius=8, fill=(245, 248, 255), outline=(200, 215, 245), width=1)
    draw.text((60, 30), "ToolShare — Logical ERD & Relational Schema (Task 2)", fill=(24, 43, 73), font=fonts["title"])
    draw.text((60, 58), "Course: INFOMAN1 | Student: Geoff Benedict P. Cariño (ID: 2511028) | Coverage: Week 3 (M:N Resolved into Junction Tables)", fill=(80, 100, 130), font=fonts["subtitle"])

    def draw_table(x, y, w, title, rows, is_junction=False):
        header_fill = (254, 239, 227) if is_junction else (232, 240, 254)
        header_border = (234, 134, 0) if is_junction else (26, 115, 232)
        row_height = 24
        header_h = 32
        h = header_h + len(rows) * row_height + 10

        draw.rounded_rectangle([x, y, x + w, y + h], radius=6, fill=(255, 255, 255), outline=header_border, width=2)
        draw.rounded_rectangle([x, y, x + w, y + header_h], radius=6, fill=header_fill, outline=header_border, width=2)
        tbox = draw.textbbox((0, 0), title, font=fonts["entity_header"])
        tw, th = tbox[2] - tbox[0], tbox[3] - tbox[1]
        tcolor = (176, 96, 0) if is_junction else (13, 71, 161)
        draw.text((x + (w - tw) / 2, y + (header_h - th) / 2), title, fill=tcolor, font=fonts["entity_header"])

        ry = y + header_h + 6
        for col_name, data_type, tag in rows:
            is_pk = "PK" in tag
            font = fonts["body_bold"] if is_pk else fonts["body"]
            draw.text((x + 12, ry), col_name, fill=(32, 33, 36), font=font)
            if is_pk:
                tbox = draw.textbbox((0, 0), col_name, font=font)
                tw = tbox[2] - tbox[0]
                draw.line([(x + 12, ry + 16), (x + 12 + tw, ry + 16)], fill=(32, 33, 36), width=1)

            draw.text((x + 120, ry), data_type, fill=(100, 110, 120), font=fonts["small"])

            if tag:
                tag_bg = (255, 235, 235) if "PK" in tag and "FK" not in tag else ((255, 243, 224) if "PK" in tag and "FK" in tag else (232, 240, 254))
                tag_border = (217, 48, 37) if "PK" in tag and "FK" not in tag else ((234, 134, 0) if "PK" in tag and "FK" in tag else (26, 115, 232))
                tag_text_col = (180, 20, 20) if "PK" in tag and "FK" not in tag else ((176, 96, 0) if "PK" in tag and "FK" in tag else (24, 90, 188))
                
                tbox = draw.textbbox((0, 0), tag, font=fonts["small"])
                tw, th = tbox[2] - tbox[0], tbox[3] - tbox[1]
                bx = x + w - tw - 16
                draw.rounded_rectangle([bx - 4, ry - 1, bx + tw + 4, ry + th + 3], radius=3, fill=tag_bg, outline=tag_border, width=1)
                draw.text((bx, ry), tag, fill=tag_text_col, font=fonts["small"])

            ry += row_height
        return x, y, w, h

    # 1. member
    draw_table(80, 240, 240, "member", [
        ("member_id", "INT", "PK"),
        ("member_name", "VARCHAR(100)", ""),
        ("phone", "VARCHAR(20)", ""),
        ("join_date", "DATE", "")
    ])

    # 2. borrowing (Junction)
    draw_table(420, 240, 250, "borrowing", [
        ("borrow_id", "INT", "PK"),
        ("member_id", "INT", "FK"),
        ("tool_id", "INT", "FK"),
        ("borrow_date", "DATE", ""),
        ("return_date", "DATE NULL", "")
    ], is_junction=True)

    # 3. tool
    draw_table(780, 240, 260, "tool", [
        ("tool_id", "INT", "PK"),
        ("tool_name", "VARCHAR(100)", ""),
        ("category", "VARCHAR(50)", ""),
        ("purchase_date", "DATE", ""),
        ("location_code", "VARCHAR(10)", "FK")
    ])

    # 4. storage_location
    draw_table(1120, 240, 250, "storage_location", [
        ("location_code", "VARCHAR(10)", "PK"),
        ("description", "VARCHAR(100)", "")
    ])

    # 5. member_certification (Junction)
    draw_table(180, 520, 270, "member_certification", [
        ("member_id", "INT", "PK, FK"),
        ("cert_id", "INT", "PK, FK"),
        ("completion_date", "DATE", "")
    ], is_junction=True)

    # 6. certification
    draw_table(570, 710, 240, "certification", [
        ("cert_id", "INT", "PK"),
        ("cert_name", "VARCHAR(100)", "")
    ])

    # 7. tool_requirement (Junction)
    draw_table(900, 520, 260, "tool_requirement", [
        ("tool_id", "INT", "PK, FK"),
        ("cert_id", "INT", "PK, FK")
    ], is_junction=True)

    def draw_crow_foot(start, end, label="1 : N"):
        sx, sy = start
        ex, ey = end
        draw.line([start, end], fill=(60, 64, 67), width=2)
        draw.line([(sx - 4, sy - 8), (sx - 4, sy + 8)], fill=(60, 64, 67), width=2)
        draw.line([(sx, sy - 8), (sx, sy + 8)], fill=(60, 64, 67), width=2)
        if ex > sx:
            draw.line([(ex, ey), (ex - 12, ey - 8)], fill=(60, 64, 67), width=2)
            draw.line([(ex, ey), (ex - 12, ey + 8)], fill=(60, 64, 67), width=2)
            draw.line([(ex - 12, ey - 8), (ex - 12, ey + 8)], fill=(60, 64, 67), width=2)
        elif ex < sx:
            draw.line([(ex, ey), (ex + 12, ey - 8)], fill=(60, 64, 67), width=2)
            draw.line([(ex, ey), (ex + 12, ey + 8)], fill=(60, 64, 67), width=2)
            draw.line([(ex + 12, ey - 8), (ex + 12, ey + 8)], fill=(60, 64, 67), width=2)
        elif ey > sy:
            draw.line([(ex, ey), (ex - 8, ey - 12)], fill=(60, 64, 67), width=2)
            draw.line([(ex, ey), (ex + 8, ey - 12)], fill=(60, 64, 67), width=2)
        else:
            draw.line([(ex, ey), (ex - 8, ey + 12)], fill=(60, 64, 67), width=2)
            draw.line([(ex, ey), (ex + 8, ey + 12)], fill=(60, 64, 67), width=2)
        
        mx, my = (sx + ex) / 2, (sy + ey) / 2
        draw.text((mx - 15, my - 16), label, fill=(24, 90, 188), font=fonts["cardinality"])

    # 1. member -> borrowing
    draw_crow_foot((320, 290), (420, 290), "1 : N")
    # 2. tool -> borrowing
    draw_crow_foot((780, 290), (670, 290), "1 : N")
    # 3. storage_location -> tool
    draw_crow_foot((1120, 290), (1040, 290), "1 : N")

    # 4. member -> member_certification
    draw.line([(200, 380), (200, 520)], fill=(60, 64, 67), width=2)
    draw.line([(192, 384), (208, 384)], fill=(60, 64, 67), width=2)
    draw.line([(192, 388), (208, 388)], fill=(60, 64, 67), width=2)
    draw.line([(200, 520), (192, 508)], fill=(60, 64, 67), width=2)
    draw.line([(200, 520), (208, 508)], fill=(60, 64, 67), width=2)
    draw.text((210, 440), "1 : N", fill=(24, 90, 188), font=fonts["cardinality"])

    # 5. certification -> member_certification
    draw.line([(570, 750), (315, 750), (315, 630)], fill=(60, 64, 67), width=2)
    draw.line([(566, 742), (566, 758)], fill=(60, 64, 67), width=2)
    draw.line([(315, 630), (307, 642)], fill=(60, 64, 67), width=2)
    draw.line([(315, 630), (323, 642)], fill=(60, 64, 67), width=2)
    draw.text((420, 725), "1 : N", fill=(24, 90, 188), font=fonts["cardinality"])

    # 6. tool -> tool_requirement
    draw.line([(950, 400), (950, 520)], fill=(60, 64, 67), width=2)
    draw.line([(942, 404), (958, 404)], fill=(60, 64, 67), width=2)
    draw.line([(942, 408), (958, 408)], fill=(60, 64, 67), width=2)
    draw.line([(950, 520), (942, 508)], fill=(60, 64, 67), width=2)
    draw.line([(950, 520), (958, 508)], fill=(60, 64, 67), width=2)
    draw.text((960, 450), "1 : N", fill=(24, 90, 188), font=fonts["cardinality"])

    # 7. certification -> tool_requirement
    draw.line([(810, 750), (1030, 750), (1030, 615)], fill=(60, 64, 67), width=2)
    draw.line([(814, 742), (814, 758)], fill=(60, 64, 67), width=2)
    draw.line([(1030, 615), (1022, 627)], fill=(60, 64, 67), width=2)
    draw.line([(1030, 615), (1038, 627)], fill=(60, 64, 67), width=2)
    draw.text((900, 725), "1 : N", fill=(24, 90, 188), font=fonts["cardinality"])

    # Legend Card
    draw.rounded_rectangle([480, 500, 830, 650], radius=8, fill=(248, 249, 250), outline=(218, 220, 224), width=1)
    draw.text((495, 510), "Logical ERD Relational Transformation (Week 3):", fill=(32, 33, 36), font=fonts["entity_header"])
    draw.text((495, 535), "• Blue Tables: 4 Core Strong Entities", fill=(60, 64, 67), font=fonts["small"])
    draw.text((495, 555), "• Yellow Tables: 3 Junction Tables (All M:N relationships resolved)", fill=(176, 96, 0), font=fonts["small"])
    draw.text((495, 575), "• PK: Primary Key (underlined) | FK: Foreign Key referencing parent", fill=(60, 64, 67), font=fonts["small"])
    draw.text((495, 595), "• tool_requirement & member_certification have Composite PKs", fill=(60, 64, 67), font=fonts["small"])
    draw.text((495, 615), "• borrowing uses surrogate PK (borrow_id) + member_id & tool_id FKs", fill=(60, 64, 67), font=fonts["small"])

    out_file = os.path.join(OUTPUT_DIR, "task2_logical_erd.png")
    img.save(out_file, "PNG")
    print("Generated task2_logical_erd.png")

generate_task1_drawio()
generate_task2_drawio()
render_task1_png()
render_task2_png()
