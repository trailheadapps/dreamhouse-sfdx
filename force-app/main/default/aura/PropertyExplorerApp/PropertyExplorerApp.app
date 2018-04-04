<aura:application extends="force:slds">

    <lightning:layout>
        <lightning:layoutItem padding="around-small" class="left" size="3">
            <c:PropertyFilters/>
        </lightning:layoutItem>
        <lightning:layoutItem padding="around-small" class="center" size="6">
            <c:PropertyTileList/>
        </lightning:layoutItem>
        <lightning:layoutItem padding="around-small" class="right" size="3">
            <c:PropertySummary/>
        </lightning:layoutItem>
    </lightning:layout>

</aura:application>