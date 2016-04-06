import qbs
import "../Utils/FindSubProjects.js" as FindSubProjects

Project
{

    references:FindSubProjects.SubProjects()
}
